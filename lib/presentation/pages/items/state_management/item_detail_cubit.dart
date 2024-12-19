import 'dart:typed_data';

import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/item/item_api_service.dart';
import 'package:collector/data/api/location/location_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/models/attachment_model.dart';
import 'package:collector/models/location_model.dart';
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
      (item) async {
        if (item?.locationId != null) {
          await _loadCollections(id);
        }
        if (item?.locationId != null) {
          await _loadLocation(item!.locationId!);
        }
        emit(
          state.copyWith(
            status: ItemDetailStatus.loaded,
            item: item,
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

  Future<void> _loadCollections(String id) async {
    final collectionsResult = await ItemApiService().getAllCollectionsOfItem(id);

    collectionsResult.result(
      (collections) => emit(
        state.copyWith(
          collections: collections,
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

  Future<void> _loadLocation(String id) async {
    final locationResult = await LocationApiService().getLocationById(id);

    locationResult.result(
      (location) => emit(
        state.copyWith(
          location: location,
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
}
