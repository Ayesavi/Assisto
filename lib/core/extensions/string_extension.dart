import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

extension StringExtensions on String {
  /// Get an environment variable value from .env file
  String get fromEnv {
    return dotenv.env[this] ?? '';
  }

  /// Capitalize the first letter of the string
  String get capitalize {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }

  OtpType get otpType {
    switch (this) {
      case "sms":
        return OtpType.sms;
      case "phoneChange":
        return OtpType.phoneChange;
      case "signup":
        return OtpType.signup;
      case "invite":
        return OtpType.invite;
      case "magiclink":
        return OtpType.magiclink;
      case "recovery":
        return OtpType.recovery;
      case "emailChange":
        return OtpType.emailChange;
      case "email":
        return OtpType.email;
      default:
        throw ArgumentError("Invalid OtpType string: $this");
    }
  }
}

extension StringNullableExtension on String? {
  bool get mayBeNullOrEmpty => (this == null || this!.trim().isEmpty);

  bool get isNotNullAndNotEmpty => (this != null && this!.trim().isNotEmpty);
}
