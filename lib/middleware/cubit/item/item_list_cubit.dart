import 'package:collector/data/database_service.dart';
import 'package:collector/model/item_model.dart';
import 'package:collector/service/collector_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemState> {
  ItemListCubit(this.databaseService) : super(const ItemState());
  final DatabaseService databaseService;

  Future<void> deleteItem(String id) async {
    await databaseService.deleteItem(id);
  }

  Future<void> loadItems() async {
    try {
      final test = await CollectorApiService().getAllItems();
      final items = await databaseService.loadAllItems();
      emit(
        state.copyWith(
          status: ItemListStatus.loaded,
          items: items.values.toList(),
        ),
      );
    } catch (e) {
      // Handle errors or emit error state
      emit(state.copyWith(status: ItemListStatus.failure));
    }
  }

  Future<void> toggleSelectionMode() async {
    emit(state.copyWith(isSelectionModeActive: !state.isSelectionModeActive));
  }
}
