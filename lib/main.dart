import 'package:assisto/app/app.dart';
import 'package:assisto/core/config/app_config.dart';
import 'package:assisto/core/crashlytics/log.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().loadEnv();
  // Initialize Firebase

  await Firebase.initializeApp(
    options: AppConfig().firebaseOptions,
  );
  await NotificationService.initLocalNotificationService();
  await Supabase.initialize(
      url: AppConfig().supabaseApiUrl, anonKey: AppConfig().supabaseApiKey);

  Log.intialize();

  runApp(const ProviderScope(child: MyApp()));
}
