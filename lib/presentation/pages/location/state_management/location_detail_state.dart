part of 'location_detail_cubit.dart';

enum LocationDetailStatus { initial, loaded, newly, edited, deleted, failure }

class LocationDetailState extends Equatable {
  const LocationDetailState({
    this.status = LocationDetailStatus.initial,
    this.location,
    this.editLocation,
    this.errorMessage,
    this.image,
  });

  final LocationDetailStatus status;
  final LocationModel? location;
  final String? errorMessage;
  final LocationModel? editLocation;
  final Uint8List? image;

  LocationDetailState copyWith({
    LocationDetailStatus? status,
    LocationModel? location,
    String? errorMessage,
    LocationModel? editLocation,
    Uint8List? image,
  }) =>
      LocationDetailState(
        status: status ?? this.status,
        location: location ?? this.location,
        errorMessage: errorMessage ?? this.errorMessage,
        editLocation: editLocation ?? this.editLocation,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        location,
        errorMessage,
        editLocation,
        image,
      ];
}
