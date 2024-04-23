import 'package:assisto/features/developer/screens/developer_menu_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<Response> callApi(String endpoint,
      {required dynamic body, String? authToken}) async {
    final options = Options(
      headers: {
        'Authorization': 'Bearer $authToken', // Add authorization header
      },
    );

    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: options,
      );
      return response;
    } catch (error) {
      throw Exception('Failed to call API: $error');
    }
  }
}

class HomeScreen extends ConsumerWidget {
  final ApiClient _apiClient = ApiClient();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const DeveloperMenuPage();
              },
            ));
          },
          child: const Text('Sign Ot'),
        ),
      ),
    );
  }
}
