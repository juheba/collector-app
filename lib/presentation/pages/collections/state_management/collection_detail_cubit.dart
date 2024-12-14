import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_detail_state.dart';

class CollectionDetailCubit extends Cubit<CollectionDetailState> {
  CollectionDetailCubit(this.databaseService) : super(const CollectionDetailState());

  final DatabaseService databaseService;

  Future<void> loadCollection(String id) async {
    try {
      final collection = await CollectionApiService().getCollectionById(id);
      //final collections_db = await databaseService.loadCollection(id);

      List<ItemModel> collectionItems;
      if (collection == null) {
        collectionItems = [];
      } else {
        collectionItems = (await CollectionApiService().getAllItemsOfCollection(collection.id)).toList();
      }
      emit(
        state.copyWith(
          status: CollectionDetailStatus.loaded,
          collection: collection,
          items: collectionItems,
          editCollection: collection,
        ),
      );
    } catch (e) {
      // Handle errors or emit error state
      emit(
        state.copyWith(
          status: CollectionDetailStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> saveCollection(CollectionModel collection) async {
    await databaseService.saveCollection(collection.id, collection);
  }

  Future<void> startEditing(CollectionModel? collection) async {
    emit(
      state.copyWith(
        status: collection != null ? CollectionDetailStatus.loaded : CollectionDetailStatus.newly,
        collection: collection,
        editCollection: collection ?? CollectionModel.blank(),
      ),
    );
  }

  Future<void> updateCollection({
    String? name,
    String? description,
    CollectionVisibility? collectionVisibility,
  }) async {
    final collection = state.editCollection;
    collection?.copyWith(
      name: name,
      description: description,
      visibility: collectionVisibility,
    );
    emit(
      state.copyWith(
        status: CollectionDetailStatus.edited,
        editCollection: collection,
      ),
    );
  }

  Future<void> submitForm() async {
    await saveCollection(state.editCollection!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editCollection: CollectionModel.blank()));
  }
}
