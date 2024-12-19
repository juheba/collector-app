part of 'location_editor_cubit.dart';

enum LocationEditorStatus {
  initial,
  loaded,
  edited,
}

class LocationEditorState extends Equatable {
  const LocationEditorState({
    this.status = LocationEditorStatus.initial,
    this.isNew = true,
    this.location,
    this.editLocation,
    this.errorMessage,
    this.image,
  });

  final LocationEditorStatus status;
  final bool isNew;
  final LocationModel? location;
  final String? errorMessage;
  final LocationModel? editLocation;
  final Uint8List? image;

  LocationEditorState copyWith({
    LocationEditorStatus? status,
    bool? isNew,
    LocationModel? location,
    String? errorMessage,
    LocationModel? editLocation,
    Uint8List? image,
  }) =>
      LocationEditorState(
        status: status ?? this.status,
        isNew: isNew ?? this.isNew,
        location: location ?? this.location,
        errorMessage: errorMessage ?? this.errorMessage,
        editLocation: editLocation ?? this.editLocation,
        image: image ?? this.image,
      );

  @override
  List<dynamic> get props => [
        status,
        isNew,
        location,
        errorMessage,
        editLocation,
        image,
      ];
}
