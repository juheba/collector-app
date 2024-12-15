import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/models/item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemState> {
  ItemListCubit(this.databaseService) : super(const ItemState());
  final DatabaseService databaseService;

  Future<void> deleteItem(String id) async {
    //await databaseService.deleteItem(id);
    await ItemApiService().deleteItem(id);
  }

  Future<void> loadItems() async {
    final result = await ItemApiService().getAllItems();
    //final items = await databaseService.loadAllItems().toList();

    result.result(
      (items) => emit(
        state.copyWith(
          status: ItemListStatus.loaded,
          items: items,
        ),
      ),
      (error) =>
          // Handle errors or emit error state
          emit(
        state.copyWith(status: ItemListStatus.failure),
      ),
    );
  }

  Future<void> toggleSelectionMode() async {
    emit(state.copyWith(isSelectionModeActive: !state.isSelectionModeActive));
  }
}
