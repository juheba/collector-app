import 'package:collector/model/item_model.dart';
import 'package:collector/data/database_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'item_list_state.dart';

class ItemListCubit extends Cubit<ItemState> {
  final DatabaseService databaseService;

  ItemListCubit(this.databaseService) : super(const ItemState());

  void deleteItem(String id) async {
    await databaseService.deleteItem(id);
  }

  Future<void> loadItems() async {
    try {
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
}
