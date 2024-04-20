import 'package:assisto/core/controllers/auth_controller.dart';
import 'package:assisto/models/task_model.dart/task_model.dart';
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
            // try {
            ref.read(authControllerProvider).signOut();
            // final authToken = await FirebaseAuth.instance.currentUser
            //     ?.getIdToken(); // Get authToken from Firebase current user
            // final response = await _apiClient.callApi(
            //   'http://localhost:5001/dev-assisto/asia-south1/apiv1/createTask',
            //   body: 0101000020E61000007E9873DF20CB5440E1FD028B0D253740

            print(TaskModel(
                    tags: ['service'],
                    title: 'title',
                    // attachedLocation: (lat: 6.298919, lng: 6.729334),
                    description: 'description',
                    createdAt: DateTime.now())
                .toJson());
            // authToken: authToken,
            // )

            //   // Handle the response
            //   if (response.statusCode == 200) {
            //     // Request successful
            //     print(response.data);
            //   } else {
            //     // Request failed
            //     print(
            //         'Request failed with status code: ${response.statusCode}');
            //   }
            // } catch (error) {
            //   // Error occurred
            //   print('Error: $error');
            // },
          },
          child: const Text('Sign Ot'),
        ),
      ),
    );
  }
}
