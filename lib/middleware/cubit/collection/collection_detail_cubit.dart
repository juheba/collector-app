import 'package:collector/data/database_service.dart';
import 'package:collector/model/collection_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_detail_state.dart';

class CollectionDetailCubit extends Cubit<CollectionDetailState> {
  CollectionDetailCubit(this.databaseService) : super(const CollectionDetailState());

  final DatabaseService databaseService;

  Future<void> loadCollection(String id) async {
    try {
      final collection = await databaseService.loadCollection(id);
      emit(
        state.copyWith(
          status: CollectionDetailStatus.loaded,
          collection: collection,
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
    collection?.update(
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
