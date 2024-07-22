import 'package:assisto/core/remote_config/remote_config_service.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppUpdateService {
  // Private constructor
  AppUpdateService._privateConstructor();

  // Singleton instance
  static final AppUpdateService _instance =
      AppUpdateService._privateConstructor();

  late String _version;

  // Getter to access the instance
  static AppUpdateService get instance => _instance;

  Future<AppUpdateInfo> checkForUpdate() async {
    return await InAppUpdate.checkForUpdate();
  }

  Future<void> initialize() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo.version.contains('-')) {
      _version = packageInfo.version.split('-')[0];
    } else {
      _version = packageInfo.version;
    }
  }

  void immediateUpdate() async {
    await InAppUpdate.performImmediateUpdate();
  }

  /// Compare current app version with the givn version
  bool compare() {
    // Compare the versions

    List<String> currentVersionParts = _version.split('.');
    List<String> targetVersionParts =
        RemoteConfigKeys.forceUpdateMinVersion.value<String>().split('.');

    for (int i = 0; i < currentVersionParts.length; i++) {
      int currentPart = int.parse(currentVersionParts[i]);
      int targetPart = int.parse(targetVersionParts[i]);

      if (currentPart < targetPart) {
        return true;
      } else if (currentPart > targetPart) {
        return false;
      }
    }

    return false;
  }
}
