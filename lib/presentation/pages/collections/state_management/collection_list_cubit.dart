import 'package:collector/data/api/collection/collection_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/models/collection_model.dart';
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
    final result = await CollectionApiService().getAllCollections();
    //final collections = (await databaseService.loadAllCollections()).values.toList();

    result.result(
      (collections) => emit(
        state.copyWith(
          status: CollectionListStatus.loaded,
          collections: collections,
        ),
      ),
      (error) => emit(
        state.copyWith(status: CollectionListStatus.failure),
      ),
    );
  }

  Future<void> toggleSelectionMode() async {
    emit(state.copyWith(isSelectionModeActive: !state.isSelectionModeActive));
  }
}
