import 'package:assisto/core/services/api_service.dart';

abstract class BaseAppFunctions {
  Future<List<String>> genCategoriesByDescription(String context);
}

class AppFunctions implements BaseAppFunctions {
  static final AppFunctions _instance = AppFunctions._internal();

  static AppFunctions get instance => _instance;

  AppFunctions._internal();

  final _apiService = HttpService();

  @override
  Future<List<String>> genCategoriesByDescription(String context) async {
    final data = await _apiService
        .post('/getCategoriesByDescription', {'context': context});
    if (data is List) {
      // Map each element of the list to String
      return data.map((element) => element.toString()).toList();
    } else {
      throw Exception('Unexpected response data format');
    }
  }
}
