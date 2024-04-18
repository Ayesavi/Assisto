import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'login_page_controller.freezed.dart';
part 'login_page_controller.g.dart';
part 'login_page_controller_state.dart';

@riverpod
class LoginPageController extends _$LoginPageController {
  final _repo = AuthRepository();
  @override
  LoginPageControllerState build() {
    return const _LoginPageControllerInitial();
  }

  Future<void> continueWithPhone(String phoneNumber) async {
    await _repo.signInWithOtp(phoneNumber);
  }

  Future<void> verifyOtp(String token, String phone, OtpType otpType) async {
    await _repo.verifyOtp(t: token,phoneNumber: phone ,otpType: otpType);
  }

  Future<void> continueWithGoogle() async {
    await _repo.signInWithGoogle();
  }
}
