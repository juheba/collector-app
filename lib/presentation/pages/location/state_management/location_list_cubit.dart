import 'package:collector/data/api/location/location_api_service.dart';
import 'package:collector/models/location_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'location_list_state.dart';

class LocationListCubit extends Cubit<LocationState> {
  LocationListCubit() : super(const LocationState());

  Future<void> loadLocations() async {
    final result = await LocationApiService().getAllLocations();

    result.result(
      (locations) => emit(
        state.copyWith(
          status: LocationListStatus.loaded,
          locations: locations,
        ),
      ),
      (error) =>
          // Handle errors or emit error state
          emit(
        state.copyWith(status: LocationListStatus.failure),
      ),
    );
  }
}
