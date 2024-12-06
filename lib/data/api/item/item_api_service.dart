import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/item/item_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/collection_api.dart';
import 'package:collector/generated/openapi/collector-api/api/item_api.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';

class ItemApiService {
  factory ItemApiService() => _instance;
  ItemApiService._internal() {
    _itemApi = AWSCollectorService().client.getItemApi();
  }

  static final ItemApiService _instance = ItemApiService._internal();

  late final ItemApi _itemApi;

  Future<List<ItemModel>> getAllItems() async {
    return getItems();
  }

  Future<List<ItemModel>> getItems({num? limit, String? nextKey}) async {
    try {
      // Call the API
      final itemsResponse = (await _itemApi.getItems(limit: limit, nextKey: nextKey)).data;

      if (itemsResponse == null) {
        return [];
      }

      return ItemMapperImpl().mapExernalToListItemModel(
        itemsResponse.items.toList(),
      );
    } catch (e) {
      // TODO: ErrorHandling einbauen!
      throw Exception('Failed to fetch collections: $e');
    }
  }

  Future<List<CollectionModel>> getAllCollectionsOfItem(String itemId) async {
    try {
      // Call the API
      final collectionItemsResponse = (await _itemApi.getItemCollections(itemId: itemId)).data;

      if (collectionItemsResponse == null) {
        return [];
      }

      return CollectionMapperImpl().mapExernalToListCollectionModel(
        collectionItemsResponse.collections.toList(),
      );
    } catch (e) {
      // TODO: ErrorHandling einbauen!
      throw Exception('Failed to fetch collections of item: $e');
    }
  }
}
