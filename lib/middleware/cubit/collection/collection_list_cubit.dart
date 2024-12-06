import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/data/api/collection/collection_api_service.dart';
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
      final collections = await CollectionApiService().getAllCollections();
      //final collections = (await databaseService.loadAllCollections()).values.toList();
      emit(
        state.copyWith(
          status: CollectionListStatus.loaded,
          collections: collections,
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
