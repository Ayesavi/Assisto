import 'package:assisto/flavors/dev/dev_options.dart' as dev;
import 'package:assisto/flavors/prod/prod_options.dart' as prod;
import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cashfree_pg_sdk/utils/cfenums.dart';

enum AppFlavors { prod, dev }

class FlavorConfig {
  FlavorConfig._();

  // The single instance of the class
  static final FlavorConfig _instance = FlavorConfig._();

  static String? _fid;

  // Factory constructor to return the same instance every time
  factory FlavorConfig() {
    Future.delayed(const Duration(seconds: 3), () {
      FirebaseInstallations.instance.getId().then((v) => _fid = v);
    });
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

  String get supabaseApiUrl => const String.fromEnvironment('SUPABASE_URL');
  String get supabaseApiKey => const String.fromEnvironment('SUPABASE_KEY');
  String get geoApiKey => const String.fromEnvironment('GEO_API_KEY');
  String get googleClientId => const String.fromEnvironment("GOOGLE_SIGN_IN");
  String? get fid => _fid;

  String get oneSignalAppId =>
      const String.fromEnvironment("ONE_SIGNAL_APP_ID");

  String get httpUrl => const String.fromEnvironment("HTTP_URL");

  bool get useFakeRepositories => const bool.fromEnvironment('faker');
  CFEnvironment get paymentEnvironment => _getPaymentEnvironment();

  FirebaseOptions get firebaseOptions {
    switch (currentFlavor) {
      case AppFlavors.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
      case AppFlavors.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
    }
  }

  CFEnvironment _getPaymentEnvironment() {
    switch (appFlavor) {
      case 'prod':
        return CFEnvironment.PRODUCTION;
      default:
        return CFEnvironment.SANDBOX;
    }
  }
}
