import 'dart:typed_data';

import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/model/attachment_model.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit(this.databaseService) : super(const ItemDetailState());

  final DatabaseService databaseService;

  Future<void> loadItem(String id) async {
    try {
      final item = await ItemApiService().getItemById(id);
      //final item = await databaseService.loadItem(id);
      emit(
        state.copyWith(
          status: ItemDetailStatus.loaded,
          item: item,
          editItem: item,
        ),
      );
    } catch (e) {
      // Handle errors or emit error state
      emit(
        state.copyWith(
          status: ItemDetailStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      lockParentWindow: true,
    );

    if (result != null) {
      final imageBytes = result.files.first.bytes;
      emit(state.copyWith(image: imageBytes));
    }
  }

  Future<void> saveItem(ItemModel item) async {
    //await databaseService.saveItem(item.id, item);
    //await loadItem(item.id);

    try {
      final ItemModel updatedItem;
      if (item.id.isEmpty) {
        updatedItem = await ItemApiService().createItem(item);
      } else {
        updatedItem = await ItemApiService().updateItem(item);
      }
      if (state.image != null) {
        final attach = await AttachmentApiService().generateItemUploadUrl(updatedItem.id);
        await S3RestApiService().uploadAttachment(attach, state.image!);
      }

      emit(
        state.copyWith(
          status: ItemDetailStatus.newly,
          item: updatedItem,
          editItem: updatedItem,
        ),
      );
    } catch (e) {
      // Handle errors or emit error state
      emit(
        state.copyWith(
          status: ItemDetailStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> startEditing(ItemModel? item) async {
    emit(
      state.copyWith(
        status: ItemDetailStatus.newly,
        item: item,
        editItem: item ?? ItemModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emit(
      state.copyWith(
        status: ItemDetailStatus.loaded,
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
    final item = state.editItem;
    item?.update(
      title: title,
      description: description,
      ownershipStatus: ownershipStatus,
      status: status,
      isLendable: isLendable,
    );
    emit(
      state.copyWith(
        status: ItemDetailStatus.edited,
        editItem: item,
      ),
    );
  }

  Future<void> delete() async {
    final key = state.item?.key as String?;
    if (key != null) {
      await databaseService.deleteItem(key);
    }
  }

  Future<void> submitForm() async {
    await saveItem(state.editItem!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editItem: ItemModel.blank()));
  }
}
