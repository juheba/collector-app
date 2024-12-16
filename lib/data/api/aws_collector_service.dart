import 'package:collector/auth/auth_service.dart';
import 'package:collector/data/api/interceptors/auth_interceptor.dart';
import 'package:collector/data/api/interceptors/logging_interceptor.dart';
import 'package:collector/data/persistence/access_user_credentials.dart';
import 'package:collector/generated/openapi/collector-api/api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AWSCollectorService {
  factory AWSCollectorService() => _instance;

  AWSCollectorService._internal() {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['REST_API_BASE_URL']!,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AuthorizationInterceptor(dio));
    dio.interceptors.add(LoggingInterceptor());

    _client = CollectorApiClient(dio: dio);
  }

  static final AWSCollectorService _instance = AWSCollectorService._internal();
  late final CollectorApiClient _client;

  CollectorApiClient get client => _client;
}
