import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config_keys.dart';
part 'remote_config_service.g.dart';
part 'remote_config_service_provider.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();

  factory RemoteConfigService() {
    return _instance;
  }

  RemoteConfigService._internal();

  static late FirebaseRemoteConfig _remoteConfig;

  /// Stream to listen for remote config updates
  static Stream<RemoteConfigUpdate> get onConfigUpdated => _configUpdateController.stream;

  static StreamController<RemoteConfigUpdate> _configUpdateController = StreamController<RemoteConfigUpdate>.broadcast();

  static Future<void> initialize({FirebaseRemoteConfig? remoteConfigInstance}) async {
    _remoteConfig = remoteConfigInstance ?? FirebaseRemoteConfig.instance;
    // Set default values for configs
    _remoteConfig.setDefaults(_getDefaultValues());

    await _remoteConfig.fetch();
    await _remoteConfig.fetchAndActivate();
    _remoteConfig.setConfigSettings(RemoteConfigSettings(
      minimumFetchInterval: const Duration(hours: 1),
      fetchTimeout: const Duration(seconds: 1), // Minimum interval to check for updates
    ));

    // Listen for updates from the original stream
    // as it only listens for updates after getting updates we will also need to activate
    // Since activation is an async operation, therefore we will add event in [_configUpdateController.sink] after
    // activation is done
    _remoteConfig.onConfigUpdated.listen((update) async {
      /// waiting for activation to complete
      await activate();
      _configUpdateController.sink.add(update);
    });
  }

  /// Returns the map default values for all the keys in the enum
  /// used to set default values for remote config while initializing remote config service
  /// see [RemoteConfigService.initialize]
  static Map<String, dynamic> _getDefaultValues() {
    var resultMap = <String, dynamic>{};
    for (var key in RemoteConfigKeys.values) {
      resultMap[key.keyName] = key.defaultValue;
    }
    return resultMap;
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
  static Future<void> fetchAndSettle() async {
    await _remoteConfig.fetchAndActivate();
  }

  /// Activates the latest fetched config.
  static Future<void> activate() async {
    await _remoteConfig.activate();
  }
}
