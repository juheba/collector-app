import 'dart:convert';

import 'package:collector/model/collection_model.dart';
import 'package:collector/service/rest_api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CollectorApiService {
  factory CollectorApiService() => _instance;

  CollectorApiService._internal();
  static final CollectorApiService _instance = CollectorApiService._internal();

  Future<List<CollectionModel>> getAllCollections() async {
    try {
      final response = await RestApiService().getData('/collections');

      if (response.statusCode == 200) {
        // TODO: hier muss dringend weiter gemacht werden....
        final collectionsData = response.data['collections'] as List<dynamic>;
        //return collectionsData.map(CollectionModel.fromJson).toList();
        return [];
      } else {
        debugPrint('Error: ${response.statusCode} - ${response.statusMessage}');
        return [];
      }
    } catch (e) {
      debugPrint('Error in getAllCollections: $e');
      return [];
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
