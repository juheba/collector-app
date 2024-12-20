import 'package:built_collection/src/list.dart';
import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/item/item_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/collection_api.dart';
import 'package:collector/generated/openapi/collector-api/model/create_collection_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_collection_items_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_collection_items_request_one_of.dart';
import 'package:collector/generated/openapi/collector-api/model/update_collection_request.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/utils/failures.dart';
import 'package:one_of/one_of.dart';
import 'package:result_type/result_type.dart';

class CollectionApiService {
  factory CollectionApiService() => _instance;
  CollectionApiService._internal() {
    _collectionApi = AWSCollectorService().client.getCollectionApi();
  }

  static final CollectionApiService _instance = CollectionApiService._internal();

  late final CollectionApi _collectionApi;

  Future<Result<List<CollectionModel>, CollectorFailure>> getAllCollections() async {
    return getCollections();
  }

  Future<Result<List<CollectionModel>, CollectorFailure>> getCollections({num? limit, String? nextKey}) async {
    try {
      // Call the API
      final collectionsResponse = (await _collectionApi.getCollections(limit: limit, nextKey: nextKey)).data;

      if (collectionsResponse == null) {
        return Success(const []);
      }

      return Success(
        CollectionMapperImpl().mapExternalToListCollectionModel(
          collectionsResponse.collections.toList(),
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections: $e'),
      );
    }
  }

  Future<Result<CollectionModel?, CollectorFailure>> getCollectionById(String collectionId) async {
    try {
      // Call the API
      final collectionResponse = (await _collectionApi.getCollection(collectionId: collectionId)).data;

      if (collectionResponse == null) {
        return Success(null);
      }

      return Success(
        CollectionMapperImpl().mapExternalToCollectionModel(
          collectionResponse.collection,
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collection: $e'),
      );
    }
  }

  Future<Result<CollectionModel, CollectorFailure>> createCollection(CollectionModel collection) async {
    try {
      final builder = CreateCollectionRequestBuilder()
        ..name = collection.name
        ..description = collection.description
        ..visibility = CollectionMapperImpl().mapCollectionVisibilityToExternal(collection.visibility);

      final collectionResponse = (await _collectionApi.createCollection(createCollectionRequest: builder.build())).data;

      if (collectionResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to create collection'),
        );
      } else {
        return Success(
          CollectionMapperImpl().mapExternalToCollectionModel(
            collectionResponse.collection,
          ),
        );
      }
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to create collection: $e'),
      );
    }
  }

  Future<Result<CollectionModel, CollectorFailure>> updateCollection(CollectionModel collection) async {
    try {
      final builder = UpdateCollectionRequestBuilder()
        ..name = collection.name
        ..description = collection.description
        ..visibility = CollectionMapperImpl().mapCollectionVisibilityToExternal(collection.visibility);

      final collectionResponse = (await _collectionApi.updateCollection(
        collectionId: collection.id,
        updateCollectionRequest: builder.build(),
      ))
          .data;

      if (collectionResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to update collection'),
        );
      } else {
        return Success(
          CollectionMapperImpl().mapExternalToCollectionModel(
            collectionResponse.collection,
          ),
        );
      }
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to update collection: $e'),
      );
    }
  }

  Future<Result<void, CollectorFailure>> deleteCollection(String collectionId) async {
    try {
      await _collectionApi.deleteCollection(collectionId: collectionId);
      return Success(null);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to delete collection: $e'),
      );
    }
  }

  Future<Result<List<ItemModel>, CollectorFailure>> getAllItemsOfCollection(String collectionId) async {
    try {
      // Call the API
      final collectionItemsResponse = (await _collectionApi.getCollectionItems(collectionId: collectionId)).data;

      if (collectionItemsResponse == null) {
        return Success(const []);
      }

      return Success(
        ItemMapperImpl().mapExternalToListItemModel(
          collectionItemsResponse.items.toList(),
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch items of collection: $e'),
      );
    }
  }

  Future<Result<void, CollectorFailure>> updateItemsOfCollection(
    String collectionId,
    List<ItemModel> items,
  ) async {
    try {
      final itemIds = items.map((item) => item.id).toList();

      final updateOneOf1 = UpdateCollectionItemsRequestOneOf(
        (builder) => builder..itemIds = ListBuilder<String>(itemIds),
      );

      final updateCollectionItemsRequest = UpdateCollectionItemsRequest(
        (builder) => builder..oneOf = OneOf.fromValue1(value: updateOneOf1),
      );

      await _collectionApi.updateCollectionItems(
        collectionId: collectionId,
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
