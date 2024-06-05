import 'package:assisto/core/analytics/base_analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService implements BaseAnalyticsService {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  @override
  void logScreen({required String name, Map<String, dynamic>? parameters}) {
    _firebaseAnalytics.logScreenView(
      screenName: name,
      parameters: parameters,
    );
  }

  @override
  void logEvent({required String name, Map<String, dynamic>? parameters}) {
    _firebaseAnalytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  @override
  void setUserId(String userId, {Map<String, dynamic>? parameters}) {
    _firebaseAnalytics.setUserId(
        id: userId, callOptions: AnalyticsCallOptions(global: true));
  }
}
