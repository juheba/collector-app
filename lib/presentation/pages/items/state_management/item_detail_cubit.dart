import 'dart:typed_data';

import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/models/attachment_model.dart';
import 'package:collector/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit(this.databaseService) : super(const ItemDetailState());

  final DatabaseService databaseService;

  Future<void> loadItem(String id) async {
    final itemResult = await ItemApiService().getItemById(id);
    //final item = await databaseService.loadItem(id);

    itemResult.result(
      (item) => emit(
        state.copyWith(
          status: ItemDetailStatus.loaded,
          item: item,
          editItem: item,
        ),
      ),
      (error) => emit(
        state.copyWith(
          status: ItemDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
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

    final updateResult =
        item.id.isEmpty ? await ItemApiService().createItem(item) : await ItemApiService().updateItem(item);

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
            status: ItemDetailStatus.newly,
            item: updatedItem,
            editItem: updatedItem,
          ),
        );
      },
      (error) => emit(
        state.copyWith(
          status: ItemDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
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
    final item = state.editItem?.copyWith(
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
    /*final key = state.item?.key as String?;
    if (key != null) {
      await databaseService.deleteItem(key);
    }*/
    try {
      await ItemApiService().deleteItem(state.item!.id);
      emit(
        state.copyWith(
          status: ItemDetailStatus.deleted,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ItemDetailStatus.failure,
        ),
      );
    }
  }

  Future<void> submitForm() async {
    await saveItem(state.editItem!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editItem: ItemModel.blank()));
  }
}
