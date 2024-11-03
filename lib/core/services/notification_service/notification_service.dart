import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';

enum NotificationChannels { task, recommendations, chat, offer }

class NotificationService {
  Future<void> requestNotificationPermission({
    required VoidCallback onGranted,
    required VoidCallback onDenied,
  }) async {
    final permission = await PermissionService()
        .requestPermissionIfNeeded(DevicePermission.notification);
    if ([DevicePermissionStatus.granted, DevicePermissionStatus.limited]
        .contains(permission)) {
      onGranted();
    } else {
      onDenied();
    }
  }

  static Future<void> initLocalNotificationService() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/notification_icon',
      [
        NotificationChannel(
          channelKey: NotificationChannels.recommendations.name,
          channelName: 'Assist Recommendations',
          channelDescription:
              'Get notified about new tasks, Assist Updates you can help with on Assist!',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
        ),
        NotificationChannel(
          channelKey: NotificationChannels.task.name,
          channelName: 'Assist Updates',
          channelDescription: 'Stay informed about the status of your Assists ',
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
              'Receive updates on bids on your created assists.',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
        ),
        NotificationChannel(
          channelKey: NotificationChannels.chat.name,
          channelName: 'Chat',
          channelDescription: 'Receive Chat Notifications',
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
        ),
      ],
      debug: kReleaseMode ? false : true,
    );
  }
}
