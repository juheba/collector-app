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

  Future<void> initForm() async {
    emit(state.copyWith(editCollection: CollectionModel.blank()));
  }
}
