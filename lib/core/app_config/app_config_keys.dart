part of 'app_config_service.dart';

/// List of the all the remote config keys
class AppConfigKeys {
  AppConfigKeys._internal();

  static final AppConfigKeys _instance = AppConfigKeys._internal();

  static AppConfigKeys get instance => _instance;
  final isAppOutage = const _AppConfigKey<bool>('is_app_outage', false);

  /// List of all the app config keys
  List<_AppConfigKey> get keys => [isAppOutage];

  /// Use this when setting the default values
  /// for the remote configuration
  Map<String, dynamic> getDefaultValue() {
    var defaultValue = <String, dynamic>{};
    for (var appConfigKey in keys) {
      defaultValue = {
        ...defaultValue,
        ...{appConfigKey.name: appConfigKey.defaultValue}
      };
    }
    return defaultValue;
  }
}

// ignore: unused_element
class _AppConfigKey<T> {
  final String name;
  // Default value for the key
  final T defaultValue;

  T value() {
    if (T == bool) {
      return AppConfigService.getBool(name) as T;
    } else if (T == double) {
      return AppConfigService.getDouble(name) as T;
    } else if (T == String) {
      return AppConfigService.getString(name) as T;
    } else {
      throw 'Data type not supported';
    }
  }

  const _AppConfigKey(this.name, this.defaultValue);
}
