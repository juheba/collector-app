import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/item/item_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/collection_api.dart';
import 'package:collector/generated/openapi/collector-api/api/item_api.dart';
import 'package:collector/generated/openapi/collector-api/model/create_item_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_item_request.dart';
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

  Future<ItemModel?> getItemById(String itemId) async {
    try {
      final itemResponse = (await _itemApi.getItem(itemId: itemId)).data;

      if (itemResponse == null) {
        return null;
      }

      return ItemMapperImpl().mapExernalToItemModel(
        itemResponse.item,
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      throw Exception('Failed to fetch collections: $e');
    }
  }

  Future<List<ItemModel>> getItems({num? limit, String? nextKey}) async {
    try {
      final itemsResponse = (await _itemApi.getItems(limit: limit, nextKey: nextKey)).data;

      if (itemsResponse == null) {
        return [];
      }

      return ItemMapperImpl().mapExernalToListItemModel(
        itemsResponse.items.toList(),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      throw Exception('Failed to fetch collections: $e');
    }
  }

  Future<ItemModel> createItem(ItemModel item) async {
    try {
      final builder = CreateItemRequestBuilder()
        ..title = item.title
        ..itemType = item.type?.name ?? ''
        ..description = item.description
        ..isLendable = item.isLendable
        ..ownershipStatus = ItemMapperImpl().mapItemOwnershipStatusToExternal(item.ownershipStatus)
        ..status = ItemMapperImpl().mapItemStatusToExternal(item.status);

      final itemResponse = (await _itemApi.createItem(createItemRequest: builder.build())).data;

      if (itemResponse == null) {
        throw Exception('Failed to create item');
      }

      return ItemMapperImpl().mapExernalToItemModel(itemResponse.item);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      throw Exception('Failed to create item: $e');
    }
  }

  Future<ItemModel> updateItem(ItemModel item) async {
    try {
      final builder = UpdateItemRequestBuilder()
        ..title = item.title
        ..itemType = item.type?.name ?? ''
        ..description = item.description
        ..isLendable = item.isLendable
        ..ownershipStatus = ItemMapperImpl().mapItemOwnershipStatusToExternal(item.ownershipStatus)
        ..status = ItemMapperImpl().mapItemStatusToExternal(item.status);

      final itemResponse = (await _itemApi.updateItem(itemId: item.id, updateItemRequest: builder.build())).data;

      if (itemResponse == null) {
        throw Exception('Failed to update item');
      }

      return ItemMapperImpl().mapExernalToItemModel(itemResponse.item);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      throw Exception('Failed to create item: $e');
    }
  }

  Future<List<CollectionModel>> getAllCollectionsOfItem(String itemId) async {
    try {
      final collectionItemsResponse = (await _itemApi.getItemCollections(itemId: itemId)).data;

      if (collectionItemsResponse == null) {
        return [];
      }

      return CollectionMapperImpl().mapExernalToListCollectionModel(
        collectionItemsResponse.collections.toList(),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      throw Exception('Failed to fetch collections of item: $e');
    }
  }
}
