import 'package:flutter_dotenv/flutter_dotenv.dart';

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
}
