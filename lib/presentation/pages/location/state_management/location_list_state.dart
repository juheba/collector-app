part of 'location_list_cubit.dart';

enum LocationListStatus { initial, loaded, failure }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationListStatus.initial,
    this.locations = const [],
    this.isSelectionModeActive = false,
  });

  final LocationListStatus status;
  final List<LocationModel> locations;
  final bool isSelectionModeActive;

  LocationState copyWith({
    LocationListStatus? status,
    List<LocationModel>? locations,
    bool? isSelectionModeActive,
  }) =>
      LocationState(
        status: status ?? this.status,
        locations: locations ?? this.locations,
        isSelectionModeActive: isSelectionModeActive ?? this.isSelectionModeActive,
      );

  @override
  List<Object?> get props => [
        status,
        locations,
        isSelectionModeActive,
      ];
}
