import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  final Map<String, String> sensitiveHeaders = {
    'Authorization': '<Bearer token>',
  };
  final String octetStreamPlaceholder = '<octet-stream data>';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrintRequestOptions(options);
    handler.next(options);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    debugPrintResponse(response);
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response == null) {
      debugPrint('No response received: ${err.message}');
    } else {
      debugPrintResponse(err.response!);
    }
    handler.next(err);
  }

  Map<String, dynamic> filterHeaders(Map<String, dynamic> headers) {
    return headers.map(
      (key, value) => MapEntry(
        key,
        sensitiveHeaders.containsKey(key) ? sensitiveHeaders[key]! : value,
      ),
    );
  }

  dynamic filterData({Map<String, dynamic>? headers, dynamic data}) {
    if (headers?['Content-Type'] == 'application/octet-stream' ||
        headers?['content-type'] == 'application/octet-stream') {
      return octetStreamPlaceholder;
    }
    return data;
  }

  void debugPrintRequestOptions(RequestOptions options) {
    final filteredHeaders = filterHeaders(options.headers);
    final filteredData = filterData(headers: options.headers, data: options.data);
    debugPrint('REQUEST => ${options.method} ${options.uri}');
    debugPrint('           Headers: $filteredHeaders');
    debugPrint('           Query Params: ${options.queryParameters}');
    debugPrint('           Data: $filteredData');
  }

  void debugPrintResponse(Response<dynamic> response) {
    final filteredHeaders = filterHeaders(response.headers.map);
    final filteredData = filterData(
      headers: response.headers.map,
      data: response.data,
    );
    debugPrint('RESPONSE <= ${response.requestOptions.method} ${response.requestOptions.uri}');
    debugPrint('           Status Code: ${response.statusCode}');
    debugPrint('           Headers: $filteredHeaders');
    debugPrint('           Data: $filteredData');
  }
}
