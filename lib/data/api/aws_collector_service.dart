import 'package:collector/auth/auth_service.dart';
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

    // Add interceptors for logging, authentication, etc., if needed
    // readUserCredentialsExporesAt()
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, handler) async {
          try {
            final credentials = await AccessUserCredentials().readUserCredentials();

            // Add Authorization header
            options.headers['Authorization'] = 'Bearer ${credentials.idToken}';
            debugPrintRequestOptions(options);
          } catch (e) {
            debugPrint('Error setting authorization header: $e');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          debugPrintResponse(response);
          return handler.next(response);
        },
        onError: (error, handler) async {
          // Handle error and retry if needed (e.g., 401 Unauthorized)
          if (error.response?.statusCode == 401) {
            final credentials = await AccessUserCredentials().readUserCredentials();
            if (credentials.refreshToken != null) {
              final newCredentials = await AuthService().refreshCredentials(refreshToken: credentials.refreshToken!);
              if (newCredentials != null) {
                await AccessUserCredentials().writeUserCredentials(newCredentials);

                // Update the request header with the new access token
                error.requestOptions.headers['Authorization'] = 'Bearer ${newCredentials.accessToken}';

                // Repeat the request with the updated header
                return handler.resolve(await dio.fetch(error.requestOptions));
              } else {
                await AuthService().logout();
              }
            }
            try {
              await AuthService().logout();
            } catch (e) {
              debugPrint('Token refresh failed: $e');
            }
          }
          return handler.next(error);
        },
      ),
    );

    _client = CollectorApiClient(dio: dio);
  }

  void debugPrintRequestOptions(RequestOptions options) {
    final filteredHeaders = options.headers.map(
      (key, value) => MapEntry(key, key == 'Authorization' ? '<Bearer token>' : value),
    );
    debugPrint('REQUEST => ${options.method} ${options.uri}');
    debugPrint('           Headers: $filteredHeaders');
    debugPrint('           Query Params: ${options.queryParameters}');
    debugPrint('           Data: ${options.data}');
  }

  void debugPrintResponse(Response<dynamic> response) {
    final filteredHeaders = response.headers.map.map(
      (key, values) => MapEntry(key, key == 'Authorization' ? ['*** MASKED ***'] : values),
    );
    debugPrint('RESPONSE <= ${response.requestOptions.method} ${response.requestOptions.uri}');
    debugPrint('           Status Code: ${response.statusCode}');
    debugPrint('           Headers: $filteredHeaders');
    debugPrint('           Data: ${response.data}');
  }

  static final AWSCollectorService _instance = AWSCollectorService._internal();
  late final CollectorApiClient _client;

  CollectorApiClient get client => _client;
}
