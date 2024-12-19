import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/data/api/attachment/attachment_api_service.dart';
import 'package:collector/data/api/location/location_api_service.dart';
import 'package:collector/data/api/s3_rest_api_service.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_editor_state.dart';

class LocationEditorCubit extends Cubit<LocationEditorState>
    with BlocPresentationMixin<LocationEditorState, EditorPresentationEvent> {
  LocationEditorCubit() : super(const LocationEditorState());

  Future<void> initEditorContext(String? id) async {
    emit(
      const LocationEditorState(),
    );
    if (id != null && id.isNotEmpty) {
      await loadLocation(id);
    }
    await startEditing();
  }

  Future<void> loadLocation(String id) async {
    final locationResult = await LocationApiService().getLocationById(id);

    locationResult.result(
      (location) => emit(
        state.copyWith(
          status: LocationEditorStatus.loaded,
          isNew: false,
          location: location,
          editLocation: location,
        ),
      ),
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> startEditing() async {
    emit(
      state.copyWith(
        status: LocationEditorStatus.loaded,
        editLocation: state.location ?? LocationModel.blank(),
      ),
    );
  }

  Future<void> cancelEditing() async {
    emitPresentation(
      EditorPresentationEventCanceled(isNew: state.isNew, id: state.editLocation?.id),
    );
  }

  Future<void> selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      lockParentWindow: true,
    );

    if (result != null) {
      final imageBytes = result.files.first.bytes;
      emit(
        state.copyWith(
          status: LocationEditorStatus.edited,
          image: imageBytes,
        ),
      );
    }
  }

  Future<void> saveChanges() async {
    final updateResult = state.isNew
        ? await LocationApiService().createLocation(state.editLocation!)
        : await LocationApiService().updateLocation(state.editLocation!);

    if (state.status != LocationEditorStatus.edited) {
      emitPresentation(EditorPresentationEventSkipSave());
      return;
    }

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
            location: updatedLocation,
            editLocation: updatedLocation,
          ),
        );
        emitPresentation(EditorPresentationEventSaved());
      },
      (error) => emitPresentation(
        EditorPresentationEventFailure(errorMessage: error.toString()),
      ),
    );
  }

  Future<void> updateChange({
    String? name,
    String? description,
  }) async {
    final location = state.editLocation?.copyWith(
      name: name,
      description: description,
    );
    emit(
      state.copyWith(
        status: LocationEditorStatus.edited,
        editLocation: location,
      ),
    );
  }

  Future<bool> deleteLocation() async {
    try {
      await LocationApiService().deleteLocation(state.location!.id);
      emitPresentation(
        EditorPresentationEventDeleted(),
      );
      return true;
    } catch (e) {
      emitPresentation(
        EditorPresentationEventFailure(errorMessage: e.toString()),
      );
    }
    return false;
  }

  Future<void> submitForm() async {
    await saveChanges();
  }
}
