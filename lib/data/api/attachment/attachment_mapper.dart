import 'package:collector/generated/openapi/collector-api/model/attachment_url_response.dart';
import 'package:collector/model/attachment_model.dart';
import 'package:smartstruct/smartstruct.dart';

part 'attachment_mapper.mapper.g.dart';

@Mapper()
abstract class AttachmentMapper {
  AttachmentModel mapExernalToAttachmentModel(AttachmentURLResponse external);
}
