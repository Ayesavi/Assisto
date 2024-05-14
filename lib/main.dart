import 'package:assisto/app/app.dart';
import 'package:assisto/core/extensions/string_extension.dart';
import 'package:assisto/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: 'SUPABASE_URL'.fromEnv, anonKey: 'SUPABASE_KEY'.fromEnv);

  runApp(const ProviderScope(child: MyApp()));
}
