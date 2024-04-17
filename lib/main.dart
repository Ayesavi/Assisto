import 'package:assisto/app/app.dart';
import 'package:assisto/firebase_options.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Use Firebase Emulators
  if (kDebugMode) {
    // Only for debug mode.
    try {
      final emulatorHost = defaultTargetPlatform == TargetPlatform.android
          ? "10.0.2.2"
          : "localhost";
      FirebaseFunctions.instance.useFunctionsEmulator(emulatorHost, 5001);
      // FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
      // FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
      // FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
  runApp(const ProviderScope(child: MyApp()));
}
