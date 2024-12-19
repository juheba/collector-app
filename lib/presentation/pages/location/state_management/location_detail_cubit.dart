import 'dart:typed_data';

import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/location/location_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_detail_state.dart';

class LocationDetailCubit extends Cubit<LocationDetailState> {
  LocationDetailCubit(this.databaseService) : super(const LocationDetailState());

  final DatabaseService databaseService;

  Future<void> loadLocation(String id) async {
    final locationResult = await LocationApiService().getLocationById(id);
    //final location = await databaseService.loadLocation(id);

    locationResult.result(
      (location) => emit(
        state.copyWith(
          status: LocationDetailStatus.loaded,
          location: location,
          editLocation: location,
        ),
      ),
      (error) => emit(
        state.copyWith(
          status: LocationDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
  }
}
