import 'package:assisto/core/analytics/repositories/firebase_analytics_repository.dart';

class AppAnalytics {
  static final AppAnalytics _instance = AppAnalytics._internal();
  final _service = FirebaseAnalyticsService();
  AppAnalytics._internal();

  static AppAnalytics get instance => _instance;

  void logScreen({required String name, Map<String, dynamic>? parameters}) {
    _service.logScreen(name: name, parameters: parameters);
  }

  void logEvent({required String name, Map<String, dynamic>? parameters}) {
    _service.logEvent(name: name, parameters: parameters);
  }

  void setUserId(String userId) {
    _service.setUserId(userId);
  }
}
