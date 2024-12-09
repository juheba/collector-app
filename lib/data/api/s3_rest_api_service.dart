import 'dart:io';
import 'dart:typed_data';

import 'package:collector/model/attachment_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class S3RestApiService {
  factory S3RestApiService() => _instance;

  S3RestApiService._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 3000),
      ),
    );
  }

  late Dio _dio;
  static final S3RestApiService _instance = S3RestApiService._internal();

  Future<void> uploadAttachment(AttachmentModel attachment, Uint8List data) async {
    if (attachment.uploadUrl == null || attachment.uploadUrl!.isEmpty) {
      throw Exception('attachment upload url is missing');
    }

    try {
      final response = await _dio.put(
        attachment.uploadUrl!,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/octet-stream',
          },
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500; // Accept any status code less than 500
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload attachment: ${response.statusCode} ${response.statusMessage}');
      }
    } on DioException catch (e) {
      final errorMessage = _handleError(e);
      debugPrint('Error: $errorMessage');
      throw Exception('Error during upload: $errorMessage');
    } catch (e) {
      throw Exception('Unexpected error during upload: $e');
    }
  }

  // Helper method to handle Dio exceptions
  String _handleError(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 400:
          return 'Bad request';
        case 401:
          return 'Unauthorized';
        case 404:
          return 'Not found';
        case 500:
          return 'Internal server error';
        default:
          return 'Something went wrong: ${e.response?.statusCode}';
      }
    } else {
      return 'No internet connection';
    }
  }
}
