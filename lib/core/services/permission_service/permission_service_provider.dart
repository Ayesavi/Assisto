import 'package:assisto/core/services/permission_service/permission_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});
