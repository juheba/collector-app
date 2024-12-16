import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:collector/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_editor_state.dart';

class CollectionEditorCubit extends Cubit<CollectionEditorState> {
  CollectionEditorCubit() : super(const CollectionEditorState());

  Future<void> saveCollection(CollectionModel collection) async {
    final updateResult = collection.id.isEmpty
        ? await CollectionApiService().createCollection(collection)
        : await CollectionApiService().updateCollection(collection);

    // ignore: cascade_invocations
    updateResult.result(
      (updatedCollection) async {
        emit(
          state.copyWith(
            status: CollectionEditorStatus.newly,
            collection: updatedCollection,
            editCollection: updatedCollection,
          ),
        );
      },
      (error) => emit(
        state.copyWith(
          status: CollectionEditorStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
  }

  Future<void> startEditing(CollectionModel? collection) async {
    emit(
      state.copyWith(
        status: CollectionEditorStatus.newly,
        collection: collection,
        editCollection: collection ?? CollectionModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emit(
      state.copyWith(
        status: CollectionEditorStatus.loaded,
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
        status: CollectionEditorStatus.edited,
        editCollection: collection,
      ),
    );
  }

  Future<bool> delete() async {
    try {
      await CollectionApiService().deleteCollection(state.collection!.id);
      return true;
    } catch (e) {
      emit(
        state.copyWith(
          status: CollectionEditorStatus.failure,
        ),
      );
      return false;
    }
  }

  Future<void> submitForm() async {
    await saveCollection(state.editCollection!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editCollection: CollectionModel.blank()));
  }
}
