import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:collector/models/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_detail_state.dart';

class CollectionDetailCubit extends Cubit<CollectionDetailState> {
  CollectionDetailCubit(this.databaseService) : super(const CollectionDetailState());

  final DatabaseService databaseService;

  Future<void> loadCollection(String id) async {
    final collectionResult = await CollectionApiService().getCollectionById(id);
    //final collections_db = await databaseService.loadCollection(id);

    collectionResult.result(
      (collection) async {
        if (collection == null) {
          emit(
            state.copyWith(
              status: CollectionDetailStatus.loaded,
              collection: collection,
              items: [],
              editCollection: collection,
            ),
          );
        } else {
          emit(
            state.copyWith(
              collection: collection,
              editCollection: collection,
            ),
          );
          await _loadItems(collection);
        }
      },
      (error) => emit(
        state.copyWith(
          status: CollectionDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
  }

  Future<void> _loadItems(CollectionModel collection) async {
    final itemsResult = await CollectionApiService().getAllItemsOfCollection(collection.id);
    itemsResult.result(
      (items) => emit(
        state.copyWith(
          status: CollectionDetailStatus.loaded,
          items: items,
        ),
      ),
      (error) => state.copyWith(
        status: CollectionDetailStatus.failure,
        errorMessage: error.toString(),
      ),
    );
  }

  Future<void> saveCollection(CollectionModel collection) async {
    final updateResult = collection.id.isEmpty
        ? await CollectionApiService().createCollection(collection)
        : await CollectionApiService().updateCollection(collection);

    // ignore: cascade_invocations
    updateResult.result(
      (updatedCollection) async {
        emit(
          state.copyWith(
            status: CollectionDetailStatus.loaded,
            collection: updatedCollection,
            editCollection: updatedCollection,
          ),
        );
      },
      (error) => emit(
        state.copyWith(
          status: CollectionDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
  }

  Future<void> startEditing(CollectionModel? collection) async {
    emit(
      state.copyWith(
        status: collection != null ? CollectionDetailStatus.edited : CollectionDetailStatus.newly,
        collection: collection,
        editCollection: collection ?? CollectionModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emit(
      state.copyWith(
        status: CollectionDetailStatus.loaded,
      ),
    );
  }

  Future<void> updateCollection({
    String? name,
    String? description,
    CollectionVisibility? visibility,
  }) async {
    final collection = state.editCollection?.copyWith(
      name: name,
      description: description,
      visibility: visibility,
    );
    emit(
      state.copyWith(
        status: CollectionDetailStatus.edited,
        editCollection: collection,
      ),
    );
  }

  Future<void> delete() async {
    try {
      await CollectionApiService().deleteCollection(state.collection!.id);
      emit(
        state.copyWith(
          status: CollectionDetailStatus.deleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionDetailStatus.failure,
        ),
      );
    }
  }

  Future<void> submitForm() async {
    await saveCollection(state.editCollection!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editCollection: CollectionModel.blank()));
  }
}
