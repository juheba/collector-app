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
}
