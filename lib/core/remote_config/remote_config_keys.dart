part of 'remote_config_service.dart';

enum RemoteConfigKeys {
  isAppOutage('is_app_outage', false),
  forceUpdateMinVersion('force_update_minimum_version', '0.3.0');

  final String keyName;
  final dynamic defaultValue;

  T value<T>() {
    if (T == bool) {
      return RemoteConfigService.getBool(keyName) as T;
    } else if (T == double) {
      return RemoteConfigService.getDouble(keyName) as T;
    } else if (T == String) {
      return RemoteConfigService.getString(keyName) as T;
    } else {
      throw 'Data type not supported';
    }
  }

  const RemoteConfigKeys(this.keyName, this.defaultValue);
}
