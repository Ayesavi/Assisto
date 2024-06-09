import 'dart:io';

import 'package:assisto/core/respositories/auth_repository.dart';
import 'package:assisto/core/utils/utils.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';
part 'auth_controller_state.dart';

@Riverpod(keepAlive: true)
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

enum AppAuthState {
  authenticated,
  loading,
  unauthenticated,

  /// When user is authenticated but profile details are not filled which is required
  unfulfilledProfile,
}

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  UserModel? _user;

  UserModel? get user => _user;

  @override
  AuthControllerState build() {
    final authStates = ref.watch(authStateChangesProvider);
    if (authStates.value?.event == null) {
      return const _AuthControllerLoading();
    }
    if (authStates.value?.session != null) {
      final sessionUser = authStates.value!.session!.user;
      final userMetadata = sessionUser.userMetadata;
      final email = sessionUser.email;
      final phone = sessionUser.phone?.isNotEmpty ?? false
          ? sessionUser.phone
          : (userMetadata != null && userMetadata.containsKey("phone")
              ? userMetadata['phone']
              : null);

      final id = sessionUser.id;
      final name = userMetadata?.containsKey("full_name") ?? false
          ? userMetadata!['full_name']
          : null;
      final imageUrl = userMetadata?.containsKey("avatar_url") ?? false
          ? userMetadata!['avatar_url']
          : null;

      final gender = userMetadata?.containsKey("gender") ?? false
          ? userMetadata!['gender']
          : null;
      final dob = userMetadata?.containsKey("dob") ?? false
          ? userMetadata!['dob']
          : null;
      final isEmailVerified =
          userMetadata?.containsKey("email_verified") ?? false
              ? userMetadata!['email_verified']
              : null;

      final description = userMetadata?.containsKey("description") ?? false
          ? userMetadata!['description']
          : null;

      final isPhoneVerified =
          userMetadata?.containsKey("phone_verified") ?? false
              ? userMetadata!['phone_verified']
              : null;

      final tags = userMetadata?.containsKey("tags") ?? false
          ? userMetadata!['tags'].map((e) => e.toString()).toList()
          : null;

      if ((checkNullOrEmpty(
              [name, gender, dob, tags])) && // todo: add image url, email
          userMetadata != null) {
        return _IncompleteProfile(userMetadata,
            isPhoneVerified: isPhoneVerified, isEmailVerified: isEmailVerified);
      }

      FirebaseAnalytics.instance.setUserId(
        id: sessionUser.id,
      );

      final model = UserModel(
          id: id,
          name: name,
          avatarUrl: imageUrl,
          gender: gender,
          email: email,
          description: description,
          phoneNumber: phone,
          tags: [...tags],
          age: calculateAgeFromString(dob));
      _user = model;
      return _Authenticated(model);
    } else {
      return const _UnAuthenticated();
    }
  }

  AuthRepository get _repo => AuthRepository();

  Future<void> signInWithOtp(String phone) async {
    await _repo.signInWithOtp(phone);
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }

  Future<User?> signInWithGoogle() async {
    return await _repo.signInWithGoogle();
  }

  Future<User?> verifyOtp(
      {required String token,
      String? phone,
      required OtpType type,
      String? email}) async {
    return await _repo.verifyOtp(
        t: token, phoneNumber: phone, email: email, otpType: type);
  }

  Future<User?> getUser() async {
    return await _repo.getUser();
  }

  Future<void> updateProfile(UserModel model) async {
    return await _repo.updateProfile(model);
  }

  Future<void> updateProfileImg(File file) async {
    final imageUrl = await _repo.uploadUserAvatar(file);
    if (user != null) {
      await _repo.updateProfile(user!.copyWith(avatarUrl: imageUrl));
    }
  }

  Future<void> updatePhone(String phone) async {
    return await _repo.updatePhone(phone);
  }

  Future<void> updateEmail(String email) async {
    return await _repo.updateEmail(email);
  }

  Future<void> resendOtp({String? phone}) async {
    await _repo.sendOtp(type: OtpType.phoneChange, phone: phone);
  }

  Future<void> reactivate({String? phone, String? email}) async {
    await _repo.reactivate(phone: phone, email: email);
  }
}
