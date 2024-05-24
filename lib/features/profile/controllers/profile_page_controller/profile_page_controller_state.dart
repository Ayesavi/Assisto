part of 'profile_page_controller.dart';

@freezed
sealed class ProfilePageControllerState with _$ProfilePageControllerState {
  const factory ProfilePageControllerState.loading() = _Loading;
  const factory ProfilePageControllerState.data({required UserModel model,  File? fileImage }) = _Data;
  const factory ProfilePageControllerState.error(Object e) = _Error;
}

extension ProfilePageControllerStateX on ProfilePageControllerState {
  bool get isLoading => this is _Loading;
  bool get isData => this is _Data;
  bool get isError => this is _Error;
}
