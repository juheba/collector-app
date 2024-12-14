import 'package:collector/generated/openapi/collector-api/model/attachment_url_response.dart';
import 'package:collector/models/attachment_model.dart';
import 'package:smartstruct/smartstruct.dart';

part 'attachment_mapper.mapper.g.dart';

@Mapper()
abstract class AttachmentMapper {
  AttachmentModel mapExternalToAttachmentModel(AttachmentURLResponse external);
}
