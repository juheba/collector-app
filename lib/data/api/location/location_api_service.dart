import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/data/api/collection/collection_mapper.dart';
import 'package:collector/data/api/location/location_mapper.dart';
import 'package:collector/generated/openapi/collector-api/api/collection_api.dart';
import 'package:collector/generated/openapi/collector-api/api/location_api.dart';
import 'package:collector/generated/openapi/collector-api/model/create_location_request.dart';
import 'package:collector/generated/openapi/collector-api/model/update_location_request.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/utils/failures.dart';
import 'package:result_type/result_type.dart';

class LocationApiService {
  factory LocationApiService() => _instance;
  LocationApiService._internal() {
    _locationApi = AWSCollectorService().client.getLocationApi();
  }

  static final LocationApiService _instance = LocationApiService._internal();

  late final LocationApi _locationApi;

  Future<Result<List<LocationModel>, CollectorFailure>> getAllLocations() async {
    return getLocations();
  }

  Future<Result<List<LocationModel>, CollectorFailure>> getLocations({num? limit, String? nextKey}) async {
    try {
      final locationsResponse = (await _locationApi.getLocations(limit: limit, nextKey: nextKey)).data;

      if (locationsResponse == null) {
        return Success(const []);
      }

      return Success(
        LocationMapperImpl().mapExternalToListLocationModel(
          locationsResponse.locations.toList(),
        ),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections: $e'),
      );
    }
  }

  Future<Result<LocationModel?, CollectorFailure>> getLocationById(String locationId) async {
    try {
      final locationResponse = (await _locationApi.getLocation(locationId: locationId)).data;

      if (locationResponse == null) {
        return Success(null);
      }

      return Success(
        LocationMapperImpl().mapExternalToLocationModel(locationResponse.location),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to fetch collections: $e'),
      );
    }
  }

  Future<Result<LocationModel, CollectorFailure>> createLocation(LocationModel location) async {
    try {
      final builder = CreateLocationRequestBuilder()
        ..name = location.name
        ..description = location.description;

      final locationResponse = (await _locationApi.createLocation(createLocationRequest: builder.build())).data;

      if (locationResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to create location'),
        );
      }

      return Success(
        LocationMapperImpl().mapExternalToLocationModel(locationResponse.location),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to create location: $e'),
      );
    }
  }

  Future<Result<LocationModel, CollectorFailure>> updateLocation(LocationModel location) async {
    try {
      final builder = UpdateLocationRequestBuilder()
        ..name = location.name
        ..description = location.description;

      final locationResponse =
          (await _locationApi.updateLocation(locationId: location.id!, updateLocationRequest: builder.build())).data;

      if (locationResponse == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to update location'),
        );
      }

      return Success(
        LocationMapperImpl().mapExternalToLocationModel(locationResponse.location),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to update location: $e'),
      );
    }
  }

  Future<Result<void, CollectorFailure>> deleteLocation(String locationId) async {
    try {
      await _locationApi.deleteLocation(locationId: locationId);
      return Success(null);
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to delete location: $e'),
      );
    }
  }
}
