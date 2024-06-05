import 'dart:io';

import 'package:assisto/shared/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException()
      : super('Please ensure that you are connected to the internet');
}

AppException appErrorHandler(dynamic e) {
  if (e is AppException) {
    return e;
  } else if (e is SocketException) {
    return NetworkException();
  } else if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'user-not-found':
        return const AppException('User not found');
      case 'wrong-password':
        return const AppException('Wrong password provided');
      case 'invalid-email':
        return const AppException('Invalid email address');
      case 'email-already-in-use':
        return const AppException('Email address is already in use');
      case 'weak-password':
        return const AppException('Password is too weak');
      case 'too-many-requests':
        return const AppException(
            'Too many login attempts. Please try again later.');
      case 'operation-not-allowed':
        return const AppException('Email/password sign-in is not enabled.');
      default:
        return AppException('Firebase Authentication Error: ${e.message}');
    }
  } else if (e is FirebaseAuthException) {
    switch (e.code) {
      case 'unknown':
        return const AppException('An unknown error occurred');
      default:
        return AppException('Firebase Error: ${e.message}');
    }
  }
  // Handle other unhandled exceptions here
  return const AppException('An error occurred');
}

tackleError(BuildContext context, Function func) {
  try {
    func();
  } catch (e) {
    showSnackBar(context, appErrorHandler(e).message);
  }
}
