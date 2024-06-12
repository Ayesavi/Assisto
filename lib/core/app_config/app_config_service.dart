import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_config_keys.dart';
part 'app_config_service.g.dart';
part 'app_config_update_provider.dart';

class AppConfigService {
  static final AppConfigService _instance = AppConfigService._internal();

  factory AppConfigService() {
    return _instance;
  }

  AppConfigService._internal();

  static final _remoteConfig = FirebaseRemoteConfig.instance;

  static final onUpdateProvider = _remoteConfigUpdateProvider;

  static Future<void> initialize() async {
    // Set default values for configs
    _remoteConfig.setDefaults(AppConfigKeys.instance.getDefaultValue());

    await _remoteConfig.fetch();
    await _remoteConfig.fetchAndActivate();
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
      minimumFetchInterval: const Duration(hours: 1),
      fetchTimeout:
          const Duration(seconds: 1), // Minimum interval to check for updates
    ));
  }

  // Get String value for a key
  static String getString(String key) {
    final value = _remoteConfig.getString(key);
    return value; // Handle null case with empty string
  }

  // Get bool value for a key
  static bool getBool(String key) {
    final value = _remoteConfig.getBool(key);
    return value; // Handle null case with default false
  }

  // Get double value for a key
  static double getDouble(String key) {
    final value = _remoteConfig.getDouble(key);
    return value; // Handle null case with default 0.0
  }

  /// Makes the last fetched config available to getters.
  static void fetchAndSettle() {
    _remoteConfig.fetchAndActivate();
  }

  /// Activates the latest fetched config.
  static void activate() {
    _remoteConfig.activate();
  }
}
