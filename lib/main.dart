import 'package:assisto/app/app.dart';
import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/crashlytics/log.dart';
import 'package:assisto/core/services/api_service.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlavorConfig().loadEnv();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: FlavorConfig().firebaseOptions,
  );
  await NotificationService.initLocalNotificationService();
  await Supabase.initialize(
      url: FlavorConfig().supabaseApiUrl,
      anonKey: FlavorConfig().supabaseApiKey);
  await MobileAds.instance.initialize();
  Log.intialize();
  // HttpService().usingEmulator(5001); 

  runApp(const ProviderScope(child: MyApp()));
}
