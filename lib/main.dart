import 'package:assisto/app/app.dart';
import 'package:assisto/core/config/app_config.dart';
import 'package:firebase_core/firebase_core.dart';
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
  await Supabase.initialize(
      url: AppConfig().supabaseApiUrl, anonKey: AppConfig().supabaseApiKey);

  runApp(const ProviderScope(child: MyApp()));
}
