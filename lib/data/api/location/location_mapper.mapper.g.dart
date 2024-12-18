// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class LocationMapperImpl extends LocationMapper {
  LocationMapperImpl() : super();

  @override
  LocationModel mapExternalToLocationModel(Location external) {
    final locationmodel = LocationModel(
      id: external.locationId,
      name: external.name,
      description: external.description,
      attachment: LocationMapper.mapExternalToAttachmentModel(external),
    );
    return locationmodel;
  }
}
