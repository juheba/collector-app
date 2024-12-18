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

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      lockParentWindow: true,
    );

    if (result != null) {
      final imageBytes = result.files.first.bytes;
      emit(state.copyWith(image: imageBytes));
    }
  }

  Future<void> saveLocation(LocationModel location) async {
    //await databaseService.saveLocation(location.id, location);
    //await loadLocation(location.id);

    final updateResult = location.id.isEmpty
        ? await LocationApiService().createLocation(location)
        : await LocationApiService().updateLocation(location);

    // ignore: cascade_invocations
    updateResult.result(
      (updatedLocation) async {
        if (state.image != null) {
          final attachResult = await AttachmentApiService().generateLocationUploadUrl(updatedLocation.id);
          if (attachResult.isSuccess) {
            await S3RestApiService().uploadAttachment(attachResult.success, state.image!);
          }
        }

        emit(
          state.copyWith(
            status: LocationDetailStatus.newly,
            location: updatedLocation,
            editLocation: updatedLocation,
          ),
        );
      },
      (error) => emit(
        state.copyWith(
          status: LocationDetailStatus.failure,
          errorMessage: error.toString(),
        ),
      ),
    );
  }

  Future<void> startEditing(LocationModel? location) async {
    emit(
      state.copyWith(
        status: LocationDetailStatus.newly,
        location: location,
        editLocation: location ?? LocationModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emit(
      state.copyWith(
        status: LocationDetailStatus.loaded,
      ),
    );
  }

  Future<void> updateLocation({
    String? name,
    String? description,
  }) async {
    final location = state.editLocation?.copyWith(
      name: name,
      description: description,
    );
    emit(
      state.copyWith(
        status: LocationDetailStatus.edited,
        editLocation: location,
      ),
    );
  }

  Future<bool> delete() async {
    /*final key = state.location?.key as String?;
    if (key != null) {
      await databaseService.deleteLocation(key);
    }*/
    try {
      await LocationApiService().deleteLocation(state.location!.id);
      emit(
        state.copyWith(
          status: LocationDetailStatus.deleted,
        ),
      );
      return true;
    } catch (e) {
      emit(
        state.copyWith(
          status: LocationDetailStatus.failure,
        ),
      );
    }
    return false;
  }

  Future<void> submitForm() async {
    await saveLocation(state.editLocation!);
  }

  Future<void> initForm() async {
    emit(state.copyWith(editLocation: LocationModel.blank()));
  }
}
