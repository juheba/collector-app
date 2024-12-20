import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/api/location/location_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/models/item_type.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_editor_state.dart';

class ItemEditorCubit extends Cubit<ItemEditorState>
    with BlocPresentationMixin<ItemEditorState, EditorPresentationEvent> {
  ItemEditorCubit() : super(const ItemEditorState());

  Future<void> initEditorContext(String? id) async {
    await _loadAvailableCollections();
    await _loadAvailableLocations();
    if (id != null && id.isNotEmpty) {
      await loadItem(id);
      await _loadCollections(id);

      if (state.item!.locationId != null) {
        await _loadLocation(state.item!.locationId!);
      }
    }
    await startEditing();
  }

  Future<void> loadItem(String id) async {
    final itemResult = await ItemApiService().getItemById(id);

    itemResult.result(
      (item) async {
        emit(
          state.copyWith(
            isNew: false,
            item: item,
            editItem: item,
          ),
        );
      },
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadCollections(String id) async {
    final collectionsResult = await ItemApiService().getAllCollectionsOfItem(id);

    collectionsResult.result(
      (collections) => emit(
        state.copyWith(
          currentCollections: collections,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadAvailableCollections() async {
    final collectionsResult = await CollectionApiService().getAllCollections();

    collectionsResult.result(
      (collections) => emit(
        state.copyWith(
          availableCollections: collections,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadLocation(String id) async {
    final locationResult = await LocationApiService().getLocationById(id);

    locationResult.result(
      (location) => emit(
        state.copyWith(
          currentLocation: location,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> _loadAvailableLocations() async {
    final locationResult = await LocationApiService().getAllLocations();

    locationResult.result(
      (locations) => emit(
        state.copyWith(
          availableLocations: locations,
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
        status: ItemEditorStatus.loaded,
        editItem: state.item ?? ItemModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emitPresentation(
      EditorPresentationEventCanceled(isNew: state.isNew, id: state.editItem?.id),
    );
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      lockParentWindow: true,
    );

    if (result != null) {
      final imageBytes = result.files.first.bytes;
      emit(
        state.copyWith(
          status: ItemEditorStatus.edited,
          image: imageBytes,
        ),
      );
    }
  }

  Future<void> saveChanges() async {
    if (state.status != ItemEditorStatus.edited) {
      emitPresentation(EditorPresentationEventSkipSave());
      return;
    }

    final updateResult = state.isNew
        ? await ItemApiService().createItem(state.editItem!)
        : await ItemApiService().updateItem(state.editItem!);

    // ignore: cascade_invocations
    updateResult.result(
      (updatedItem) async {
        if (state.image != null) {
          final attachResult = await AttachmentApiService().generateItemUploadUrl(updatedItem.id);
          if (attachResult.isSuccess) {
            await S3RestApiService().uploadAttachment(attachResult.success, state.image!);
          }
        }

        emit(
          state.copyWith(
            item: updatedItem,
            editItem: updatedItem,
          ),
        );
        emitPresentation(EditorPresentationEventSaved());
      },
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );

    await _saveCollectionsChanges();
  }

  Future<bool> _saveCollectionsChanges() async {
    if (state.hasCollectionsChanged == false) {
      return true;
    }

    try {
      await ItemApiService().updateCollectionsOfItem(state.editItem!.id, state.currentCollections!);
      return true;
    } catch (e) {
      emitPresentation(
        EditorPresentationEventFailure(errorMessage: e.toString()),
      );
    }
    return false;
  }

  Future<void> updateItem({
    String? title,
    String? description,
    ItemType? type,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
    String? locationId,
    bool? isLendable,
  }) async {
    final item = state.editItem?.copyWith(
      title: title,
      description: description,
      type: type,
      ownershipStatus: ownershipStatus,
      status: status,
      locationId: locationId,
      isLendable: isLendable,
    );
    emit(
      state.copyWith(
        status: ItemEditorStatus.edited,
        editItem: item,
      ),
    );
  }

  Future<void> updateCollections({
    required List<CollectionModel> collections,
  }) async {
    emit(
      state.copyWith(
        status: ItemEditorStatus.edited,
        currentCollections: collections,
        hasCollectionsChanged: true,
      ),
    );
  }

  Future<bool> deleteItem() async {
    try {
      await ItemApiService().deleteItem(state.item!.id);
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
