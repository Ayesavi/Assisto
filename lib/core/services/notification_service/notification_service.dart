import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

enum NotificationChannels { task, recommendations, chat, offer }

class NotificationService {
  final Ref ref;

  NotificationService(this.ref) {
    _initialize();
  }

  void _initialize() {
    ref.listen<AuthControllerState>(authControllerProvider, (previous, next) {
      next.maybeWhen(
        authenticated: (userModel) => _oneSignalLogin(userModel),
        unAuthenticated: () => _oneSignalLogout(),
        orElse: () => null,
      );
    });
  }

  void _oneSignalLogin(UserModel userModel) async {
    await OneSignal.login(userModel.id);
  }

  void _oneSignalLogout() {
    OneSignal.logout();
  }

  Future<void> shareLocation({
    required VoidCallback onGranted,
    required VoidCallback onDenied,
  }) async {
    final permission = await PermissionService()
        .requestPermissionIfNeeded(DevicePermission.location);
    if ([DevicePermissionStatus.granted, DevicePermissionStatus.limited]
        .contains(permission)) {
      await OneSignal.Location.setShared(true);
    } else {
      onDenied();
    }
  }

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
      debug: true,
    );
  }

  void handleOnClickOneSignalNotification(
    BuildContext context,
    OSNotificationClickEvent event,
  ) {
    Future.delayed(const Duration(milliseconds: 500), () {
      context.go(event.notification.additionalData!['navigate']);
    });
  }
}
