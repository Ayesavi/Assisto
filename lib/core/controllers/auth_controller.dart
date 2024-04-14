import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part "auth_controller.g.dart";

@Riverpod(keepAlive: true)
AuthController authController(AuthControllerRef ref) {
  final authStates = ref.watch(authStateChangesProvider);
  if (authStates.value != null) {
    return const AuthController(AppAuthState.authenticated);
  } else {
    return const AuthController(AppAuthState.unauthenticated);
  }
}

@Riverpod(keepAlive: true)
Stream<User?> authStateChanges(AuthStateChangesRef ref) {
  return FirebaseAuth.instance.authStateChanges();
}

enum AppAuthState {
  authenticated,
  loading,
  unauthenticated,
  anonymous,

  /// When user is authenticated but profile details are not filled
  /// which is required
  unfulfilledProfile
}

class AuthController {
  final AppAuthState state;

  const AuthController(this.state);

  BaseAuthRepository get _repo => FirebaseAuthRepository();

  Future<User?> get user => _repo.getUser();

  Future<void> signInWithOtp(String phone) async {
    await _repo.signInWithPhoneNumber(phone);
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }

  Future<void> signInWithGoogle() async {
    return _repo.signInWithGoogle();
  }

  Future<void> verifyOtp(
      {required String verificationId, required String otp}) async {
    return _repo.verifyOtp(verificationId: verificationId, otp: otp);
  }

  Future<User?> getUser() async {
    return await _repo.getUser();
  }
}
