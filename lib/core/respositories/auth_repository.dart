import 'package:assisto/core/extensions/string_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithPhoneNumber(String phoneNumber,
      {void Function(String vId, int? resToken)? onCodeSent,
      void Function(FirebaseAuthException exception)? onFailed,
      void Function(String vId)? onTimeOut});
  Future<void> signOut();
  Future<void> updateProfile({String? displayName, String? photoURL});
  Future<User?> getUser();
  Future<void> verifyOtp({required String verificationId, required String otp});
}

class FirebaseAuthRepository implements BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signInWithGoogle() async {
    try {
      if (!kIsWeb) {
        final GoogleSignIn googleSignIn = GoogleSignIn(
            serverClientId: !kIsWeb ? "GOOGLE_CLIENT_ID".fromEnv : null,
            clientId: kIsWeb ? "GOOGLE_CLIENT_ID".fromEnv : null,
            scopes: ['email', 'openid']);
        final GoogleSignInAccount? googleSignInAccount =
            await googleSignIn.signIn();
        if (googleSignInAccount != null) {
          final GoogleSignInAuthentication googleSignInAuthentication =
              await googleSignInAccount.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );
          await _firebaseAuth.signInWithCredential(credential);
        }
      } else {
        // Create a new provider
        GoogleAuthProvider googleProvider = GoogleAuthProvider();

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithPopup(googleProvider);

        // Or use signInWithRedirect
        // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
      }
    } catch (error) {
      return;
    }
    return;
  }

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber,
      {void Function(String vId, int? resToken)? onCodeSent,
      void Function(FirebaseAuthException exception)? onFailed,
      void Function(String vId)? onTimeOut}) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          onCodeSent?.call(verificationId, resendToken);
          // Handle code sent
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );

      // _firebaseAuth.signInWithPhoneNumber(phoneNumber)
    } catch (error) {
      return;
    }
    return;
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (error) {
      // ignore
    }
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      final User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
      }
      if (photoURL != null && user != null) {
        await user.updatePhotoURL(photoURL);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> verifyOtp(
      {required String verificationId, required String otp}) async {
    // Create a PhoneAuthCredential using the verification ID and OTP
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: otp,
    );

    // Sign in the user with the credential
    await _firebaseAuth.signInWithCredential(credential);
  }
}

class FakeAuthRepository implements BaseAuthRepository {
  @override
  Future<User?> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile({String? displayName, String? photoURL}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOtp(
      {required String verificationId, required String otp}) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber,
      {void Function(String vId, int? resToken)? onCodeSent,
      void Function(FirebaseAuthException exception)? onFailed,
      void Function(String vId)? onTimeOut}) {
    // TODO: implement signInWithPhoneNumber
    throw UnimplementedError();
  }
}
