import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/flavors/dev/dev_options.dart' as dev;
import 'package:assisto/flavors/prod/prod_options.dart' as prod;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppFlavors { prod, dev }

class AppConfig {
  const AppConfig._();

  // The single instance of the class
  static const AppConfig _instance = AppConfig._();

  // Factory constructor to return the same instance every time
  factory AppConfig() {
    return _instance;
  }

  AppFlavors get currentFlavor {
    switch (appFlavor) {
      case 'dev':
        return AppFlavors.dev;
      case 'prod':
        return AppFlavors.prod;
      default:
        return AppFlavors.dev;
    }
  }

  String get supabaseApiUrl => 'SUPABASE_URL'.fromEnv;
  String get supabaseApiKey => 'SUPABASE_KEY'.fromEnv;
  String get geoApiKey => 'GEO_API_KEY'.fromEnv;
  String get googleClientId => "GOOGLE_SIGN_IN".fromEnv;

  FirebaseOptions get firebaseOptions {
    switch (currentFlavor) {
      case AppFlavors.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case AppFlavors.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }

  Future<void> loadEnv() async {
    const fileName = '.env.$appFlavor';
    await dotenv.load(fileName: fileName);
  }
}
