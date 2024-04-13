import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuthRepository {
  Future<void> signInWithGoogle();
  Future<void> signInWithPhoneNumber(String phoneNumber);
  Future<void> signOut();
  Future<void> updateProfile({String? displayName, String? photoURL});
  Future<User?> getUser();
  Future<void> verifyOtp({required String verificationId, required String otp});
}

class AuthRepository implements BaseAuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      serverClientId: const String.fromEnvironment("GOOGLE_CLIENT_ID"),
      scopes: ['email', 'openid']);

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        await _firebaseAuth.signInWithCredential(credential);
      }
    } catch (error) {
      return;
    }
    return;
  }

  @override
  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {},
        codeSent: (String verificationId, int? resendToken) {
          // Handle code sent
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
        },
      );
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
      // Handle error
    }
  }

  @override
  Future<User?> getUser() async {
    try {
      return _firebaseAuth.currentUser;
    } catch (e) {
      //ignore
    }
    return null;
  }

  @override
  Future<void> verifyOtp(
      {required String verificationId, required String otp}) async {
    try {
      // Create a PhoneAuthCredential using the verification ID and OTP
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );

      // Sign in the user with the credential
      await _firebaseAuth.signInWithCredential(credential);
    } catch (error) {
      // Handle error
    }
  }
}
