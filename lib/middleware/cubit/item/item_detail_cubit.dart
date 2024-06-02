import 'package:collector/data/database_service.dart';
import 'package:collector/model/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_detail_state.dart';

class ItemDetailCubit extends Cubit<ItemDetailState> {
  ItemDetailCubit(this.databaseService) : super(const ItemDetailState());

  final DatabaseService databaseService;

  Future<void> loadItem(String id) async {
    try {
      final item = await databaseService.loadItem(id);
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

  Future<void> saveItem(ItemModel item) async {
    await databaseService.saveItem(item.id, item);
  }

  Future<void> startEditing(ItemModel? item) async {
    emit(
      state.copyWith(
        status: item != null ? ItemDetailStatus.loaded : ItemDetailStatus.newly,
        item: item,
        editItem: item ?? ItemModel.blank(),
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

  Future<void> submitForm() async {
    await saveItem(state.editItem!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editItem: ItemModel.blank()));
  }
}
