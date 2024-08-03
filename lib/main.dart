import 'package:assisto/app/app.dart';
import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/crashlytics/log.dart';
import 'package:assisto/core/remote_config/remote_config_service.dart';
import 'package:assisto/core/services/notification_service/notification_service.dart';
import 'package:assisto/widgets/app_error_widget/app_error_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase
  await Firebase.initializeApp(
    options: FlavorConfig().firebaseOptions,
  );
  //Remove this method to stop OneSignal Debugging

  await NotificationService.initLocalNotificationService();
  await Supabase.initialize(
      url: FlavorConfig().supabaseApiUrl,
      anonKey: FlavorConfig().supabaseApiKey);
  await MobileAds.instance.initialize();
  Log.intialize();

  RemoteConfigService.initialize();
  if (kReleaseMode) ErrorWidget.builder = (_) => const AppErrorWidget();
  if (kDebugMode) {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }
  OneSignal.initialize(FlavorConfig().oneSignalAppId);
  await OneSignal.Notifications.requestPermission(true);
  // HttpService().usingEmulator(5001);

  runApp(const ProviderScope(child: MyApp()));
}
