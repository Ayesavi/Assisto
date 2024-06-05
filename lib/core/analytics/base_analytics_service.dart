abstract class BaseAnalyticsService {
  void logScreen({required String name, Map<String, dynamic>? parameters});
  void logEvent({required String name, Map<String, dynamic>? parameters});
  void setUserId(String userId, {Map<String, dynamic>? parameters});
}



