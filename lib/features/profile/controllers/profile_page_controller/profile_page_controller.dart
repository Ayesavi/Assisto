import 'dart:io';

import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:assisto/core/services/image_service/image_service.dart';
import 'package:assisto/core/services/permission_service.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter_chatbook/flutter_chatbook.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_page_controller.freezed.dart';
part 'profile_page_controller.g.dart';
part 'profile_page_controller_state.dart';

@riverpod
class ProfilePageController extends _$ProfilePageController {
  late AuthController _controller;
  final imageService = ImageServiceImpl();
  final permissionService = PermissionService();
  File? imageFile;
  @override
  ProfilePageControllerState build() {
    ref.watch(authStateChangesProvider);
    _controller = ref.read(authControllerProvider.notifier);
    final model = _controller.user;

    if (model != null) {
      return _Data(model: model);
    }
    return const _Loading();
  }

  getProfileDetails() {
    try {
      final model = _controller.user;
      if (model != null) {
        state = _Data(model: model, fileImage: imageFile);
        return;
      }
      throw UnAuthenticatedUserException();
    } catch (e) {
      state = _Error(e);
    }
  }

  requestImagePermission({
    required VoidCallBack onPermissionPermanentlyDenied,
    required VoidCallBack onPermissionGranted,
    required VoidCallBack onPermissionDenied,
  }) async {
    final status = await permissionService
        .requestPermissionIfNeeded(DevicePermission.photos);
    if (status.isGranted || status.isLimited) {
      onPermissionGranted();
    } else if (status.isPermanentlyDenied) {
      onPermissionPermanentlyDenied();
    } else if (status.isDenied) {
      onPermissionDenied();
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final imagePath = pickedFile?.path;
    if (imagePath != null) {
      imageFile = await _validate(File(imagePath));
      await _controller.updateProfileImg(imageFile!);
    }
    if (_controller.user != null) {
      state = _Data(model: _controller.user!, fileImage: imageFile);
    }
    return;
  }

  Future<File?> _validate(File file) async {
    if (!imageService.validate(file,
        maxSize: 2, maxHeight: 200, maxWidth: 200)) {
      return await imageService.resize(file, maxWidth: 400, maxHeight: 400);
    }
    return file;
  }
}
