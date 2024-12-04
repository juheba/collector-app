import 'package:collector/data/database_service.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/service/collector_api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'collection_list_state.dart';

class CollectionListCubit extends Cubit<CollectionState> {
  CollectionListCubit(this.databaseService) : super(const CollectionState());
  final DatabaseService databaseService;

  Future<void> deleteCollection(String id) async {
    await databaseService.deleteCollection(id);
  }

  Future<void> loadCollections() async {
    try {
      final onlinecollections = await CollectorApiService().getAllCollections();
      final collections = await databaseService.loadAllCollections();
      emit(
        state.copyWith(
          status: CollectionListStatus.loaded,
          collections: collections.values.toList(),
        ),
      );
    } catch (e) {
      // Handle errors or emit error state
      emit(state.copyWith(status: CollectionListStatus.failure));
    }
  }

  Future<void> toggleSelectionMode() async {
    emit(state.copyWith(isSelectionModeActive: !state.isSelectionModeActive));
  }
}
