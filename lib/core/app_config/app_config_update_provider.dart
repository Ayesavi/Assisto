part of 'app_config_service.dart';

@Riverpod(keepAlive: true)
Stream<RemoteConfigUpdate> _remoteConfigUpdate(_RemoteConfigUpdateRef ref) {
  return FirebaseRemoteConfig.instance.onConfigUpdated;
}

@Riverpod(keepAlive: true)
AppConfigKeys appConfigKeys(AppConfigKeysRef ref) {
  ref.watch(_remoteConfigUpdateProvider);
  AppConfigService.fetchAndSettle();
  return AppConfigKeys.instance;
}
