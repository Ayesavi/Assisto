import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class Log {
  static void intialize() {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
      runZonedGuarded(() {
        FlutterError.onError = Log.recordNonFatalError;
        // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          Log.recordFatalError(error, stack);
          return true;
        };
      }, (error, stack) {
        Log.recordFatalError(error, stack);
      });
    }
  }

  static void recordFatalError(dynamic error, StackTrace stackTrace) {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
    }
  }

  static void recordNonFatalError(FlutterErrorDetails error) async {
    if (!kDebugMode) {
      FirebaseCrashlytics.instance
          .recordError(error.exception, error.stack, fatal: false);
    }
  }
}
