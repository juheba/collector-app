import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/item/item_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/collection_api.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';

class CollectionApiService {
  factory CollectionApiService() => _instance;
  CollectionApiService._internal() {
    _collectionApi = AWSCollectorService().client.getCollectionApi();
  }

  static final CollectionApiService _instance = CollectionApiService._internal();

  late final CollectionApi _collectionApi;

  Future<List<CollectionModel>> getAllCollections() async {
    return getCollections();
  }

  Future<List<CollectionModel>> getCollections({num? limit, String? nextKey}) async {
    try {
      // Call the API
      final collectionsResponse = (await _collectionApi.getCollections(limit: limit, nextKey: nextKey)).data;

      if (collectionsResponse == null) {
        return [];
      }

      return CollectionMapperImpl().mapExernalToListCollectionModel(
        collectionsResponse.collections.toList(),
      );
    } catch (e) {
      // TODO: ErrorHandling einbauen!
      throw Exception('Failed to fetch collections: $e');
    }
  }

  Future<List<ItemModel>> getAllItemsOfCollection(String collectionId) async {
    try {
      // Call the API
      final collectionItemsResponse = (await _collectionApi.getCollectionItems(collectionId: collectionId)).data;

      if (collectionItemsResponse == null) {
        return [];
      }

      return ItemMapperImpl().mapExernalToListItemModel(
        collectionItemsResponse.items.toList(),
      );
    } catch (e) {
      // TODO: ErrorHandling einbauen!
      throw Exception('Failed to fetch items of collection: $e');
    }
  }
}
