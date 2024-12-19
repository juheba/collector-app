import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_editor_state.dart';

class ItemEditorCubit extends Cubit<ItemEditorState>
    with BlocPresentationMixin<ItemEditorState, EditorPresentationEvent> {
  ItemEditorCubit() : super(const ItemEditorState());

  Future<void> initEditorContext(String? id) async {
    emit(
      const ItemEditorState(),
    );
    if (id != null && id.isNotEmpty) {
      await loadItem(id);
    }
    await startEditing();
  }

  Future<void> loadItem(String id) async {
    final itemResult = await ItemApiService().getItemById(id);

    itemResult.result(
      (item) => emit(
        state.copyWith(
          status: ItemEditorStatus.loaded,
          isNew: false,
          item: item,
          editItem: item,
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
    final updateResult = state.isNew
        ? await ItemApiService().createItem(state.editItem!)
        : await ItemApiService().updateItem(state.editItem!);

    if (state.status != ItemEditorStatus.edited) {
      emitPresentation(EditorPresentationEventSkipSave());
      return;
    }

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
  }

  Future<void> updateItem({
    String? title,
    String? description,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
    bool? isLendable,
  }) async {
    final item = state.editItem?.copyWith(
      title: title,
      description: description,
      ownershipStatus: ownershipStatus,
      status: status,
      isLendable: isLendable,
    );
    emit(
      state.copyWith(
        status: ItemEditorStatus.edited,
        editItem: item,
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
