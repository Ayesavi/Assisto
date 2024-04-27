part of 'auth_controller.dart';

@freezed
sealed class AuthControllerState with _$AuthControllerState {
  const AuthControllerState._();
  const factory AuthControllerState.authControllerInitial() = _AuthControllerLoading;
  const factory AuthControllerState.authenticated(UserModel model) = _Authenticated;
  const factory AuthControllerState.unAuthenticated() = _UnAuthenticated;
  const factory AuthControllerState.inCompleteProfile(Map<String,dynamic> data,{bool? isPhoneVerified, bool? isEmailVerified }) = _IncompleteProfile;


}

extension AuthControllerStateX on AuthControllerState {
  /// States are loading
  bool get isLoading => this is _AuthControllerLoading;
  bool get isUnAuthenticated => this is _UnAuthenticated;
  bool get isAuthenticated => this is _Authenticated;
  bool get isInCompleteProfile => this is _IncompleteProfile;
  
}
