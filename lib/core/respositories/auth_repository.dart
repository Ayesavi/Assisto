import 'dart:io';

import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/error/handler.dart';
import 'package:assisto/core/services/api_service.dart';
import 'package:assisto/models/user_model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  // Singleton instance
  static final AuthRepository _instance = _AuthRepositoryImpl();

  factory AuthRepository() => _instance;

  // Abstract methods
  Future<void> signInWithOtp(String phone);
  Future<void> signOut();
  Future<User?> signInWithGoogle();
  Future<User?> verifyOtp(
      {required String t,
      String? phoneNumber,
      String? email,
      required OtpType otpType});
  Future<User?> getUser();
  Future<void> sendOtp({required OtpType type, String? phone, String? email});
  Future<void> updateProfile(UserModel model);
  Future<void> updateEmail(String email);
  Future<void> updatePhone(String phone);
  Future<String> uploadUserAvatar(File file);
  Future<Map<String, dynamic>> getDisabledUserReason(
      {String? email, String? phone});
  Future<void> reactivate({String? phone, String? email});
}

class UnAuthenticatedUserException implements Exception {
  @override
  String toString() {
    return 'User is not authenticated';
  }
}

class _AuthRepositoryImpl implements AuthRepository {
  final _supabase = Supabase.instance.client;

  /// Sends Otp to a phonenumber against which you are
  /// doing verification.

  @override
  Future<void> signInWithOtp(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
    } catch (e) {
      if (e is AuthApiException) {
        if (e.statusCode == '400') {
          final response = await getDisabledUserReason(phone: phone);
          throw UserDisabledException(response['reason'],
              isForDeletion: response['is_for_deletion'], phone: phone);
        }
      }
    }
  }

  /// Signs out from the localdevice
  @override
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleUser = await _googleSignIn.signIn();

    try {
      if (!kIsWeb && Platform.isAndroid) {
        final googleAuth = await googleUser?.authentication;
        final accessToken = googleAuth?.accessToken;
        final idToken = googleAuth?.idToken;
        if (accessToken != null && idToken != null) {
          final response = await _supabase.auth.signInWithIdToken(
            provider: OAuthProvider.google,
            idToken: idToken,
            accessToken: accessToken,
          );
          if (response.user != null) {
            return (response.user!);
          }
          throw UnAuthenticatedUserException();
        }
      } else {
        await _supabase.auth.signInWithOAuth(OAuthProvider.google);
      }
      throw UnAuthenticatedUserException();
    } catch (e) {
      if (e is AuthApiException) {
        if (e.statusCode == '400') {
          final response =
              await getDisabledUserReason(email: googleUser?.email);
          throw UserDisabledException(response['reason'],
              isForDeletion: response['is_for_deletion'],
              email: googleUser?.email);
        }
      }
      rethrow;
    }
  }

  @override
  Future<User?> verifyOtp(
      {required String t,
      String? phoneNumber,
      String? email,
      required OtpType otpType}) async {
    final response = (await _supabase.auth.verifyOTP(
            token: t, type: otpType, phone: phoneNumber, email: email))
        .user;
    if (response != null) {
      return (response);
    }
    throw UnAuthenticatedUserException();
  }

  @override
  Future<User?> getUser() async {
    if (_supabase.auth.currentUser != null) {
      return ((_supabase.auth.currentUser!));
    }
    return null;
  }

  GoogleSignIn get _googleSignIn => GoogleSignIn(
      serverClientId: FlavorConfig().googleClientId,
      scopes: ['email', "openid"]);

  @override
  Future<void> sendOtp(
      {required OtpType type, String? phone, String? email}) async {
    try {
      await _supabase.auth.resend(type: type, phone: phone);
    } catch (e) {
      // ignore
    }
  }

  @override
  Future<void> updateProfile(newModel) async {
    await _supabase.auth
        .updateUser(UserAttributes(data: newModel.toSupaJson()));
  }

  @override
  Future<void> updateEmail(String email) async {
    await _supabase.auth.updateUser(UserAttributes(email: email));
  }

  @override
  Future<void> updatePhone(String phone) async {
    (await _supabase.auth
        .updateUser(UserAttributes(phone: phone, data: {'phone': phone})));
  }

  @override
  Future<String> uploadUserAvatar(File file) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      final publicUrl =
          _supabase.storage.from('avatars').getPublicUrl('$userId');
      return publicUrl;
    } catch (e) {
      throw 'Failed to upload avatar';
    }
  }

  @override
  Future<Map<String, dynamic>> getDisabledUserReason(
      {String? email, String? phone}) async {
    try {
      final data = await HttpService().post(
          '/apiv1/user/disabled-reason', {"email": email, "phone": phone});
      return data;
    } catch (e) {
      throw 'Failed to get disabled user reason';
    }
  }

  @override
  Future<void> reactivate({String? phone, String? email}) async {
    try {
      final data = await HttpService()
          .post('/apiv1/user/reactivate', {"email": email, "phone": phone});
      return data;
    } catch (e) {
      throw 'Failed to get disabled user reason';
    }
  }
}
