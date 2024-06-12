// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationServiceHash() =>
    r'273353af352e9fb76194c00254dec9b24755632c';

/// See also [notificationService].
@ProviderFor(notificationService)
final notificationServiceProvider = Provider<NotificationService>.internal(
  notificationService,
  name: r'notificationServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef NotificationServiceRef = ProviderRef<NotificationService>;
String _$onMessageRecievedHash() => r'e2098de049312e7dd74d91c0bba49bda115fa1a9';

/// See also [onMessageRecieved].
@ProviderFor(onMessageRecieved)
final onMessageRecievedProvider = StreamProvider<RemoteMessage?>.internal(
  onMessageRecieved,
  name: r'onMessageRecievedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onMessageRecievedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OnMessageRecievedRef = StreamProviderRef<RemoteMessage?>;
String _$onMessageOpenedAppHash() =>
    r'646b5115e56d81d04e8e7656fa04840e4020e895';

/// `onMessageOpenedApp` is called only when app is in background (but not terminated!) and user taps on notification that was delivered previously (so, since when app is in foreground all messages are sent to onMessage, it had to be delivered when app was in background).
///
/// Copied from [onMessageOpenedApp].
@ProviderFor(onMessageOpenedApp)
final onMessageOpenedAppProvider = StreamProvider<RemoteMessage?>.internal(
  onMessageOpenedApp,
  name: r'onMessageOpenedAppProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onMessageOpenedAppHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OnMessageOpenedAppRef = StreamProviderRef<RemoteMessage?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
