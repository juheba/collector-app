import 'package:collector/service/rest_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CollectorApiService {
  factory CollectorApiService() => _instance;

  CollectorApiService._internal();
  static final CollectorApiService _instance = CollectorApiService._internal();

  Future<Response> getAllCollections() async {
    try {
      final response = await RestApiService().getData('/collections');
      return response;
    } catch (e) {
      debugPrint('Error: $e');
      return Response(requestOptions: RequestOptions(path: ''));
    }
  }

  Future<Response> getAllItems() async {
    try {
      final response = await RestApiService().getData('/items');
      return response;
    } catch (e) {
      debugPrint('Error: $e');
      return Response(requestOptions: RequestOptions(path: ''));
    }
  }
}
