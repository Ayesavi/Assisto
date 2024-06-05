import 'dart:math';

import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/router/routes.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/models/notification_events/chat_event_info/chat_event_info.dart';
import 'package:assisto/models/notification_events/recommendations_event_info/new_task_recommendation_event_info/new_task_recommendation_event_info.dart';
import 'package:assisto/models/notification_events/task_event_info/task_update_event_info.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationChannels { task, recommendations, chat }


class NotificationService {
  final Ref ref;
  final _supabase = Supabase.instance.client;
  final _messaging = FirebaseMessaging.instance;

  NotificationService(this.ref) {
    init();
  }

  init() {
    final event = ref.watch(authStateChangesProvider);
    _syncToken(event);
    _messaging.onTokenRefresh.listen((token) async {
      _saveToken(token);
    });
    ref.listen(onMessageRecievedProvider, (prev, next) {
      if (next.hasValue) {
        showNotification(next.value!);
      }
    });
  }

  static initLocalNotificationService() async {
    await AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelKey: NotificationChannels.recommendations.name,
            channelName: 'Assist Recommendations',
            channelDescription:
                'Get notified about new tasksAssist Updates you can help with on Assist!',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
          NotificationChannel(
            channelKey: NotificationChannels.task.name,
            channelName: 'Assist Updates',
            channelDescription:
                'Stay informed about the status of your Assists ',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
          NotificationChannel(
            channelKey: NotificationChannels.chat.name,
            channelName: 'Chat',
            channelDescription:
                'Never miss a message on Assist - stay connected with those you\'re helping or getting help from.',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
        ],
        debug: true);

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<void> _syncToken(AsyncValue<AuthState> event) async {
    if (event.value?.event == AuthChangeEvent.signedIn) {
      final token = await _messaging.getToken();
      if (token != null) {
        await _saveToken(token);
      }
    }
  }

  Future<void> _saveToken(String token) async {
    await _supabase.from('devices').insert({'token': token});
  }

  Future<void> removeToken() async {
    final token = await _messaging.getToken();
    await _supabase.from('devices').delete().eq('token', token ?? '');
  }

  void handleInitialMessage(
    BuildContext context,
  ) {
    _messaging.getInitialMessage().then((remoteMessage) {
      if (remoteMessage != null) {
        handlePressNotification(context, remoteMessage);
      }
    });
  }

  void handlePressNotification(BuildContext context, RemoteMessage message) {
    final channel = message.data['channel'];
    final eventInfo = message.data;
    switch (channel) {
      case 'recommendations':
        _handlePressRecommendations(
            context, NewTaskRecommendationEventInfo.fromJson(eventInfo));
        break;
      case 'task':
        _handlePressTask(context, TaskUpdateEventInfo.fromJson(eventInfo));
        break;
      case 'chat':
        _handlePressChat(context, ChatEventInfo.fromJson(eventInfo));
        break;
    }
  }

  _handlePressRecommendations(
      BuildContext context, NewTaskRecommendationEventInfo info) {
    TaskProfileRoute(taskId: int.parse(info.taskId)).go(context);
  }

  _handlePressTask(BuildContext context, TaskUpdateEventInfo info) {
    TaskProfileRoute(taskId: int.parse(info.taskId)).go(context);
  }

  _handlePressChat(BuildContext context, ChatEventInfo info) {
    ChatPageRoute(roomId: int.parse(info.roomId)).go(context);
  }

  void showNotification(
    RemoteMessage message,
  ) async {
    final channel =
        message.data.containsKey('channel') ? message.data['channel'] : null;
    final title =
        message.data.containsKey('title') ? message.data['title'] : null;
    final body = message.data.containsKey('body') ? message.data['body'] : null;
    final bigPicture = message.data.containsKey('image_url')
        ? message.data['image_url']
        : null;
    final id = message.data.containsKey('id')
        ? message.data['id']
        : Random().nextInt(10000);
    final groupKey = message.data.containsKey('group_key')
        ? message.data['group_key']
        : channel;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: channel,
            title: title,
            bigPicture: bigPicture,
            body: body,
            groupKey: groupKey));
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(
  RemoteMessage? message,
) async {
  if (message != null) {
    final channel =
        message.data.containsKey('channel') ? message.data['channel'] : null;
    final title =
        message.data.containsKey('title') ? message.data['title'] : null;
    final body = message.data.containsKey('body') ? message.data['body'] : null;
    final bigPicture = message.data.containsKey('image_url')
        ? message.data['image_url']
        : null;
    final id = message.data.containsKey('id')
        ? message.data['id']
        : Random().nextInt(10000);
    final groupKey = message.data.containsKey('group_key')
        ? message.data['group_key']
        : channel;
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: id,
            channelKey: channel,
            title: title,
            bigPicture: bigPicture,
            body: body,
            groupKey: groupKey));
  }
}
