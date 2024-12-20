import 'package:built_collection/src/list.dart';
import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/item/item_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/item_api.dart';
import 'package:collector/generated/openapi/collector-api/model/create_item_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_collection_items_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_collection_items_request_one_of1.dart';
import 'package:collector/generated/openapi/collector-api/model/update_item_request.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/utils/failures.dart';
import 'package:one_of/one_of.dart';
import 'package:result_type/result_type.dart';

class ItemApiService {
  factory ItemApiService() => _instance;
  ItemApiService._internal() {
    _itemApi = AWSCollectorService().client.getItemApi();
  }

  static final ItemApiService _instance = ItemApiService._internal();

  late final ItemApi _itemApi;

  Future<Result<List<ItemModel>, CollectorFailure>> getAllItems() async {
    return getItems();
  }

  Future<Result<ItemModel?, CollectorFailure>> getItemById(String itemId) async {
    try {
      final itemResponse = (await _itemApi.getItem(itemId: itemId)).data;

      if (itemResponse == null) {
        return Success(null);
      }

      return Success(
        ItemMapperImpl().mapExternalToItemModel(itemResponse.item),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections: $e'),
      );
    }
  }

  Future<Result<List<ItemModel>, CollectorFailure>> getItems({num? limit, String? nextKey}) async {
    try {
      final itemsResponse = (await _itemApi.getItems(limit: limit, nextKey: nextKey)).data;

      if (itemsResponse == null) {
        return Success(const []);
      }

      return Success(
        ItemMapperImpl().mapExternalToListItemModel(
          itemsResponse.items.toList(),
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections: $e'),
      );
    }
  }

  Future<Result<ItemModel, CollectorFailure>> createItem(ItemModel item) async {
    try {
      final builder = CreateItemRequestBuilder()
        ..title = item.title
        ..itemType = item.type?.name
        ..description = item.description
        ..locationId = item.locationId
        ..isLendable = item.isLendable
        ..ownershipStatus = ItemMapperImpl().mapItemOwnershipStatusToExternal(item.ownershipStatus)
        ..status = ItemMapperImpl().mapItemStatusToExternal(item.status);

      final itemResponse = (await _itemApi.createItem(createItemRequest: builder.build())).data;

      if (itemResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to create item'),
        );
      }

      return Success(
        ItemMapperImpl().mapExternalToItemModel(itemResponse.item),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to create item: $e'),
      );
    }
  }

  Future<Result<ItemModel, CollectorFailure>> updateItem(ItemModel item) async {
    try {
      final builder = UpdateItemRequestBuilder()
        ..title = item.title
        ..itemType = ItemMapperImpl().mapItemTypeToExternal(item.type)
        ..description = item.description
        ..locationId = item.locationId
        ..isLendable = item.isLendable
        ..ownershipStatus = ItemMapperImpl().mapItemOwnershipStatusToExternal(item.ownershipStatus)
        ..status = ItemMapperImpl().mapItemStatusToExternal(item.status);

      final itemResponse = (await _itemApi.updateItem(itemId: item.id, updateItemRequest: builder.build())).data;

      if (itemResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to update item'),
        );
      }

      return Success(
        ItemMapperImpl().mapExternalToItemModel(itemResponse.item),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to update item: $e'),
      );
    }
  }

  Future<Result<void, CollectorFailure>> deleteItem(String itemId) async {
    try {
      await _itemApi.deleteItem(itemId: itemId);
      return Success(null);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to delete item: $e'),
      );
    }
  }

  Future<Result<List<CollectionModel>, CollectorFailure>> getAllCollectionsOfItem(String itemId) async {
    try {
      final collectionItemsResponse = (await _itemApi.getItemCollections(itemId: itemId)).data;

      if (collectionItemsResponse == null) {
        return Success(const []);
      }

      return Success(
        CollectionMapperImpl().mapExternalToListCollectionModel(
          collectionItemsResponse.collections.toList(),
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections of item: $e'),
      );
    }
  }

  Future<Result<void, CollectorFailure>> updateCollectionsOfItem(
    String itemId,
    List<CollectionModel> collections,
  ) async {
    try {
      final collectionIds = collections.map((collection) => collection.id).toList();

      final updateOneOf1 = UpdateCollectionItemsRequestOneOf1(
        (builder) => builder..collectionIds = ListBuilder<String>(collectionIds),
      );

      final updateCollectionItemsRequest = UpdateCollectionItemsRequest(
        (builder) => builder..oneOf = OneOf.fromValue1(value: updateOneOf1),
      );

      await _itemApi.updateItemCollections(
        itemId: itemId,
        updateCollectionItemsRequest: updateCollectionItemsRequest,
      );

      return Success(null);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to update item collections: $e'),
      );
    }
  }
}
