import 'package:collector/data/access_user_credentials.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RestApiService {
  factory RestApiService() => _instance;

  RestApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['REST_API_BASE_URL']!,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }

  late Dio _dio;
  static final RestApiService _instance = RestApiService._internal();

  Future<Response> getData(String endpoint) async {
    try {
      final idToken = await AccessUserCredentials().readUserCredentialsIdToken();
      _dio.options.headers.putIfAbsent(
        'Authorization',
        () => 'Bearer $idToken',
      );
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      _dio.options.headers
          .putIfAbsent('Authorization', () => 'Bearer ${AccessUserCredentials().readUserCredentialsIdToken()}');
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      return _handleDioException(e);
    }
  }

  Future<Response> _handleDioException(DioException e) async {
    String errorMessage;
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          errorMessage = 'Bad request';
          break;
        case 401:
          errorMessage = 'Unauthorized';
          break;
        case 404:
          errorMessage = 'Not found';
          break;
        default:
          errorMessage = 'Something went wrong';
      }
    } else {
      errorMessage = 'No internet connection';
    }
    debugPrint('Error: $errorMessage');
    return e.response ?? Response(requestOptions: RequestOptions(path: ''));
  }
}
