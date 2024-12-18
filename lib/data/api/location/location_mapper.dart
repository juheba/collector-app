import 'package:collector/generated/openapi/collector-api/model/location.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/models/models.dart';
import 'package:smartstruct/smartstruct.dart';

part 'location_mapper.mapper.g.dart';

@Mapper()
abstract class LocationMapper {
  @IgnoreMapping()
  List<LocationModel> mapExternalToListLocationModel(List<Location> external) {
    return external.map(mapExternalToLocationModel).toList();
  }

  @Mapping(source: 'locationId', target: 'id')
  @Mapping(source: mapExternalToAttachmentModel, target: 'attachment')
  LocationModel mapExternalToLocationModel(Location external);

  @IgnoreMapping()
  static AttachmentModel mapExternalToAttachmentModel(Location external) {
    return AttachmentModel(attachmentUrl: external.attachmentUrl);
  }
}
