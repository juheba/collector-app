import 'package:collector/auth/auth_service.dart';
import 'package:collector/data/persistence/access_user_credentials.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthorizationInterceptor extends Interceptor {
  AuthorizationInterceptor(this.dio);

  final Dio dio;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final credentials = await AccessUserCredentials().readUserCredentials();
      options.headers['Authorization'] = 'Bearer ${credentials.idToken}';
    } catch (e) {
      debugPrint('Error setting authorization header: $e');
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403) {
      final credentials = await AccessUserCredentials().readUserCredentials();
      if (credentials.refreshToken != null) {
        final newCredentials = await AuthService().refreshCredentials(refreshToken: credentials.refreshToken!);
        if (newCredentials != null) {
          await AccessUserCredentials().writeUserCredentials(newCredentials);

          // Update the request header with the new access token
          err.requestOptions.headers['Authorization'] = 'Bearer ${newCredentials.accessToken}';

          // Repeat the request with the updated header
          return handler.resolve(await dio.fetch(err.requestOptions));
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
    return handler.next(err);
  }
}
