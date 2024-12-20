import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_editor_state.dart';

class CollectionEditorCubit extends Cubit<CollectionEditorState>
    with BlocPresentationMixin<CollectionEditorState, EditorPresentationEvent> {
  CollectionEditorCubit() : super(const CollectionEditorState());

  Future<void> initEditorContext(String? id) async {
    await _loadAvailableItems();
    if (id != null && id.isNotEmpty) {
      await loadCollection(id);
      await _loadItems(id);
    }
    await startEditing();
  }

  Future<void> loadCollection(String id) async {
    final collectionResult = await CollectionApiService().getCollectionById(id);

    collectionResult.result(
      (collection) async {
        emit(
          state.copyWith(
            isNew: false,
            collection: collection,
            editCollection: collection,
          ),
        );
      },
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadItems(String id) async {
    final itemsResult = await CollectionApiService().getAllItemsOfCollection(id);

    itemsResult.result(
      (items) => emit(
        state.copyWith(
          currentItems: items,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadAvailableItems() async {
    final itemsResult = await ItemApiService().getAllItems();

    itemsResult.result(
      (items) => emit(
        state.copyWith(
          availableItems: items,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> startEditing() async {
    emit(
      state.copyWith(
        status: CollectionEditorStatus.loaded,
        editCollection: state.collection ?? CollectionModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emitPresentation(
      EditorPresentationEventCanceled(isNew: state.isNew, id: state.editCollection?.id),
    );
  }

  Future<void> saveChanges() async {
    if (state.status != CollectionEditorStatus.edited) {
      emitPresentation(EditorPresentationEventSkipSave());
      return;
    }

    final updateResult = state.isNew
        ? await CollectionApiService().createCollection(state.editCollection!)
        : await CollectionApiService().updateCollection(state.editCollection!);

    // ignore: cascade_invocations
    updateResult.result(
      (updatedCollection) async {
        emit(
          state.copyWith(
            collection: updatedCollection,
            editCollection: updatedCollection,
          ),
        );
        emitPresentation(EditorPresentationEventSaved());
      },
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );

    await _saveItemsChanges();
  }

  Future<bool> _saveItemsChanges() async {
    if (state.hasItemsChanged == false) {
      return true;
    }

    try {
      await CollectionApiService().updateItemsOfCollection(state.editCollection!.id, state.currentItems!);
      return true;
    } catch (e) {
      emitPresentation(
        EditorPresentationEventFailure(errorMessage: e.toString()),
      );
    }
    return false;
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

  Future<void> updateItems({
    required List<ItemModel> items,
  }) async {
    emit(
      state.copyWith(
        status: CollectionEditorStatus.edited,
        currentItems: items,
        hasItemsChanged: true,
      ),
    );
  }

  Future<bool> deleteCollection() async {
    try {
      await CollectionApiService().deleteCollection(state.collection!.id);
      emitPresentation(
        EditorPresentationEventDeleted(),
      );
      return true;
    } catch (e) {
      emitPresentation(
        EditorPresentationEventFailure(errorMessage: e.toString()),
      );
    }
    return false;
  }

  Future<void> submitForm() async {
    await saveChanges();
  }
}
