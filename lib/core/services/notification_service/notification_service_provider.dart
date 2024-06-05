import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_service_provider.g.dart';

@Riverpod(keepAlive: true)
NotificationService notificationService(NotificationServiceRef ref) {
  return NotificationService(ref);
}

@Riverpod(keepAlive: true)
Stream<RemoteMessage?> onMessageRecieved(OnMessageRecievedRef ref) {
  return FirebaseMessaging.onMessage;
}

/// `onMessageOpenedApp` is called only when app is in background (but not terminated!) and user taps on notification that was delivered previously (so, since when app is in foreground all messages are sent to onMessage, it had to be delivered when app was in background).
@Riverpod(keepAlive: true)
Stream<RemoteMessage?> onMessageOpenedApp(OnMessageOpenedAppRef ref) {
  return FirebaseMessaging.onMessageOpenedApp;
}
