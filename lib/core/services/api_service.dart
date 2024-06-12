import 'dart:io';

import 'package:assisto/core/extensions/string_extension.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HttpService {
  late Dio _dio;
  final String _baseUrl = "HTTP_URL".fromEnv;

  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl, headers: _getHeaders()));
  }

  Dio get dio => _dio;

  _getHeaders() {
    return {
      'authorization':
          'Bearer ${Supabase.instance.client.auth.currentSession?.accessToken}',
      // ...Supabase.instance.client.auth.headers
    };
  }

  Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? body}) async {
    try {
      final response = await _dio.get(endpoint,
          queryParameters: queryParameters, data: body);
      return response.data;
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }

  /// When using http service locally.
  usingEmulator(int port) {
    final url =
        'http://${!kIsWeb && Platform.isAndroid ? '10.0.2.2:${port.toString()}' : 'localhost:${port.toString()}'}/${appFlavor == 'prod' ? 'dev-assisto' : 'assisto-dev-52a1d'}/asia-south1';
    _dio = Dio(BaseOptions(baseUrl: url, headers: _getHeaders()));
  }
}
