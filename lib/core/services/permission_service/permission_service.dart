import 'package:assisto/core/types/queued_stream.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

typedef DeniedPermissionStreamModel = ({
  DevicePermissionStatus status,
  DevicePermission permission,
  bool? isMandatory
});

enum DevicePermission {
  camera,
  storage,
  notification,
  location,
  photos,
}

enum DevicePermissionStatus {
  granted,
  limited,
  denied,
  restricted,
  provisional,
  permanentlyDenied
}

enum MandatoryPermissions {
  location,
}

extension GetBoolStatus on DevicePermissionStatus {
  bool get isGranted => this == DevicePermissionStatus.granted;
  bool get isLimited => this == DevicePermissionStatus.limited;
  bool get isDenied => this == DevicePermissionStatus.denied;
  bool get isRestricted => this == DevicePermissionStatus.restricted;
  bool get isProvisional => this == DevicePermissionStatus.provisional;
  bool get isPermanentlyDenied =>
      this == DevicePermissionStatus.permanentlyDenied;
}

abstract class BasePermissionService {
  Future<DevicePermissionStatus> checkPermission(DevicePermission permission);
  Future<DevicePermissionStatus> requestPermissionIfNeeded(
      DevicePermission permission);
  Future<Map<DevicePermission, DevicePermissionStatus>>
      requestPermissionsIfNeeded(List<DevicePermission> permissions);
  Future<void> openSettings();
}

class PermissionService implements BasePermissionService {
  final deniedPermissionStream = QueuedStream<DeniedPermissionStreamModel>();

  @override
  Future<void> openSettings() async {
    await openAppSettings();
  }

  @override
  Future<DevicePermissionStatus> requestPermissionIfNeeded(
      DevicePermission permission) {
    if (kIsWeb &&
        [DevicePermission.photos, DevicePermission.storage]
            .contains(permission)) {
      return Future.value(DevicePermissionStatus.granted);
    }
    return _maptoPermission(permission).request().then((permissionStatus) {
      final status = _mapToDevicePermissionStatus(permissionStatus);
      if ([
        DevicePermissionStatus.denied,
        DevicePermissionStatus.permanentlyDenied
      ].contains(status)) {
        deniedPermissionStream.add(
          (
            status: status,
            permission: permission,
            isMandatory: isPermissionMandatory(permission),
          ),
        );
      }
      return status;
    });
  }

  bool isPermissionMandatory(DevicePermission permission) {
    return MandatoryPermissions.values
        .map((e) => e.name)
        .contains(permission.name);
  }

  @override
  Future<Map<DevicePermission, DevicePermissionStatus>>
      requestPermissionsIfNeeded(List<DevicePermission> permissions) async {
    final mappedPermissions = permissions.map(_maptoPermission).toList();
    final mappedPermissionStatus = await mappedPermissions.request();
    final Map<DevicePermission, DevicePermissionStatus> result = {};
    mappedPermissionStatus.forEach((key, value) {
      result[_mapToDevicePermission(key)] = _mapToDevicePermissionStatus(value);
    });
    return result;
  }

  @override
  Future<DevicePermissionStatus> checkPermission(
      DevicePermission permission) async {
    if (!kIsWeb) {
      final status = await _maptoPermission(permission).status;
      return _mapToDevicePermissionStatus(status);
    }

    return DevicePermissionStatus.granted;
  }

  Permission _maptoPermission(DevicePermission permission) {
    if (permission == DevicePermission.camera) {
      return Permission.camera;
    } else if (permission == DevicePermission.storage) {
      return Permission.storage;
    } else if (permission == DevicePermission.notification) {
      return Permission.notification;
    } else if (permission == DevicePermission.location) {
      return Permission.location;
    } else if (permission == DevicePermission.photos) {
      return Permission.photos;
    } else {
      // Handle the case where the input permission is not recognized
      // You might want to throw an exception, return a default permission, or handle it in some other way based on your requirements.
      // For now, I'm returning Permission.unknown as an example.
      return Permission.unknown;
    }
  }

  DevicePermission _mapToDevicePermission(Permission permission) {
    if (permission == Permission.camera) {
      return DevicePermission.camera;
    } else if (permission == Permission.location) {
      return DevicePermission.location;
    } else if (permission == Permission.storage) {
      return DevicePermission.storage;
    } else if (permission == Permission.notification) {
      return DevicePermission.notification;
    } else if (permission == Permission.photos) {
      return DevicePermission.photos;
    } else {
      throw "Unhandled Permission";
    }
  }

  DevicePermissionStatus _mapToDevicePermissionStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        return DevicePermissionStatus.denied;
      case PermissionStatus.granted:
        return DevicePermissionStatus.granted;
      case PermissionStatus.restricted:
        return DevicePermissionStatus.restricted;
      case PermissionStatus.limited:
        return DevicePermissionStatus.limited;
      case PermissionStatus.permanentlyDenied:
        return DevicePermissionStatus.permanentlyDenied;
      case PermissionStatus.provisional:
        return DevicePermissionStatus.provisional;
    }
  }
}
