import 'package:assisto/core/services/api_service.dart';
import 'package:assisto/models/payments/payment_req_model/payment_req_model.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';

abstract class BaseAppFunctions {
  Future<List<String>> genCategoriesByDescription(String context);
  Future<TaskModel> createAssistUsingAI(String context);
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

  Future<PaymentReqModel> createOrder(int bidId) async {
    final data =
        await _apiService.post('/apiv1/payments/createOrder', {'bidId': bidId});

    return PaymentReqModel.fromJson(data);
  }

  @override
  Future<TaskModel> createAssistUsingAI(String context) async {
    final data = await _apiService
        .post('/apiv1/assists/createUsingAI', {'context': context});

    // Handle null values and typecasting
    final List<String> tags = List<String>.from(data['tags']);
    final String title = data['title'] as String;
    final String description = data['description'] as String;
    // final DateTime? deadline = data['deadline'] != null
    //     ? DateTime.parse(data['deadline']).toLocal()
    //     : null;
    final String? ageGroup = data['ageGroup'] as String?;
    final Gender gender =
        data['gender'] == 'male' ? Gender.male : Gender.female;

    // final int? expectedPrice =
    //     data['budget'] != null ? data['budget'] as int : null;

    return TaskModel.partial(
      tags: tags,
      title: title,
      description: description,
      deadline: null,
      ageGroup: ageGroup,
      gender: gender,
      expectedPrice: null,
    );
  }
}
