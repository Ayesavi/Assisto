part of 'remote_config_service.dart';

@Riverpod(keepAlive: true)
Stream<RemoteConfigUpdate> remoteConfigUpdate(RemoteConfigUpdateRef ref) {
  return RemoteConfigService.onConfigUpdated;
}
