import 'dart:io';

import 'package:assisto/core/respositories/address_repository/auth_repository.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppException implements Exception {
  final String message;

  const AppException(this.message);
}

class NetworkException extends AppException {
  NetworkException()
      : super('Please ensure that you are connected to the internet');
}

class UserDisabledException extends AppException {
  final bool isForDeletion;
  final String? phone;
  final String? email;

  const UserDisabledException(super.message,
      {required this.isForDeletion, this.phone, this.email});
}

AppException appErrorHandler(dynamic e) {
  if (e is AppException) {
    return e;
  } else if (e is SocketException) {
    return NetworkException();
  } else if (e is PostgrestException ||
      e is AuthPKCEGrantCodeExchangeError ||
      e is AuthException ||
      e is UnAuthenticatedUserException) {
    return AppException(e.message);
  } else if (e is PlatformException) {
    if (e.code == "network_error") {
      return NetworkException();
    } else {
      return const AppException("An error occurred");
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
