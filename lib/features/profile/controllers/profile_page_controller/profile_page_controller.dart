import 'package:assisto/core/controllers/auth_controller/auth_controller.dart';
import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_page_controller.freezed.dart';
part 'profile_page_controller.g.dart';
part 'profile_page_controller_state.dart';

@riverpod
class ProfilePageController extends _$ProfilePageController {
  late AuthController _controller;

  @override
  ProfilePageControllerState build() {
    ref.watch(authStateChangesProvider);
    _controller = ref.read(authControllerProvider.notifier);
    final model = _controller.user;

    if (model != null) {
      return _Data(model);
    }
    return const _Loading();
  }

  getProfileDetails() {
    try {
      final model = _controller.user;
      if (model != null) {
        state = _Data(model);
        return;
      }
      throw UnAuthenticatedUserException();
    } catch (e) {
      state = _Error(e);
    }
  }
}
