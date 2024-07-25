import 'dart:math';

import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/services/notification_service/notification_service_provider.dart';
import 'package:assisto/features/chat/screens/chat_page.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationChannels { task, recommendations, chat, offer }

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
      _handleNotification(next.value);
    });
  }

  static initLocalNotificationService() async {
    await AwesomeNotifications().initialize(
        'resource://drawable/notification_icon',
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
            channelKey: NotificationChannels.offer.name,
            channelName: 'Bids & Offers',
            channelDescription:
                'Recieve updates on bids on your created assists.',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
          NotificationChannel(
            channelKey: NotificationChannels.chat.name,
            channelName: 'Chat',
            channelDescription: 'Recieve Chat Notifications',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
          ),
        ],
        debug: true);

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: (ReceivedAction receivedAction) async {
    //     NotificationController.onActionReceivedMethod(receivedAction);
    //   },
    //   onNotificationCreatedMethod:
    //       (ReceivedNotification receivedNotification) async {
    //     NotificationController.onNotificationCreatedMethod(
    //         receivedNotification);
    //   },
    //   onNotificationDisplayedMethod:
    //       (ReceivedNotification receivedNotification) async {
    //     NotificationController.onNotificationDisplayedMethod(
    //         receivedNotification);
    //   },
    //   onDismissActionReceivedMethod: (ReceivedAction receivedAction) async {
    //     NotificationController.onDismissActionReceivedMethod(receivedAction);
    //   },
    // );
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

    AwesomeNotifications().getInitialNotificationAction().then((action) {
      if (action != null) {
        handleActionNotification(context, action);
      }
    });

    AwesomeNotifications().setListeners(onActionReceivedMethod: (action) async {
      handleActionNotification(context, action);
    });
  }

  handleActionNotification(BuildContext context, ReceivedAction action) {
    context.go(action.payload?['navigate'] ?? '');
  }

  void handlePressNotification(BuildContext context, RemoteMessage message) {
    context.go(message.data['navigate']);
  }
}

@pragma('vm:entry-point')
Future<void> _backgroundMessageHandler(
  RemoteMessage? message,
) async {
  _handleNotification(message, isBackground: true);
}

_handleNotification(RemoteMessage? message, {bool isBackground = false}) {
  if (message != null) {
    final channel =
        message.data.containsKey('channel') ? message.data['channel'] : null;
    switch (channel) {
      case 'chat':
        if (ChatPage.activeRoom.toString() != message.data['group_key']) {
          _showChatNotification(message);
        }
        break;
      case 'task':
        if (!isBackground) {
          _showNotification(
              channel: channel,
              title: message.notification!.title!,
              payload: {...message.data},
              body: message.notification!.body!);
        }
      default:
    }
  }
}

void _showNotification(
    {required String channel,
    required String title,
    required Map<String, String> payload,
    required String body}) async {
  await AwesomeNotifications().createNotification(
      content: NotificationContent(
    id: Random().nextInt(1000),
    channelKey: channel,
    payload: payload,
    title: title,
    body: body,
  ));
}

void _showChatNotification(
  RemoteMessage message,
) async {
  final title = message.data['title'];
  final body = message.data['body'];
  final userAvatar = message.data['user_avatar'];
  final groupKey = message.data['group_key'];

  await AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(1000),
          channelKey: NotificationChannels.chat.name,
          payload: {...message.data},
          title: title,
          roundedLargeIcon: true,
          largeIcon: userAvatar,
          body: body,
          notificationLayout: NotificationLayout.MessagingGroup,
          groupKey: groupKey));
}
