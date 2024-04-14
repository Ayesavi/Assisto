import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_page_controller.freezed.dart';
part 'login_page_controller.g.dart';
part 'login_page_controller_state.dart';

@riverpod
class LoginPageController extends _$LoginPageController {
  final BaseAuthRepository _repo = FirebaseAuthRepository();
  @override
  LoginPageControllerState build() {
    return const _LoginPageControllerInitial();
  }

  Future<void> continueWithPhone(String phoneNumber,
      {void Function(String vId, int? resToken)? onCodeSent,
      void Function(FirebaseAuthException exception)? onFailed,
      void Function(String vId)? onTimeOut}) async {
    await _repo.signInWithPhoneNumber(phoneNumber,
        onCodeSent: onCodeSent, onFailed: onFailed, onTimeOut: onTimeOut);
  }

  Future<void> verifyOtp(String verificationId, String otp) async {
    await _repo.verifyOtp(verificationId: verificationId, otp: otp);
  }
}
