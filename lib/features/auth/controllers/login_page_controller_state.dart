part of 'login_page_controller.dart';

@freezed
sealed class LoginPageControllerState with _$LoginPageControllerState {
  const LoginPageControllerState._();
  
  const factory LoginPageControllerState.initial() =
      _LoginPageControllerInitial;

  const factory LoginPageControllerState.networkError() = _NetworkError;
}

extension LoginPageControllerStateX on LoginPageControllerState {
  bool get isInitial => this is _LoginPageControllerInitial;
  bool get isNetworkError => this is _NetworkError;
}
