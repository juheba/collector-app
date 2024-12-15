import 'package:collector/data/api/attachment/attachment_mapper.dart';
import 'package:collector/data/api/aws_collector_service.dart';
import 'package:collector/generated/openapi/collector-api/api/attachment_api.dart';
import 'package:collector/generated/openapi/collector-api/model/create_item_attachment_request.dart';
import 'package:collector/generated/openapi/collector-api/model/create_location_attachment_request.dart';
import 'package:collector/generated/openapi/collector-api/model/generate_upload_url_request.dart';
import 'package:collector/models/attachment_model.dart';
import 'package:collector/utils/failures.dart';
import 'package:one_of/one_of.dart';
import 'package:result_type/result_type.dart';

class AttachmentApiService {
  factory AttachmentApiService() => _instance;
  AttachmentApiService._internal() {
    _attachmentApi = AWSCollectorService().client.getAttachmentApi();
  }

  static final AttachmentApiService _instance = AttachmentApiService._internal();

  late final AttachmentApi _attachmentApi;

  Future<Result<AttachmentModel, CollectorFailure>> generateItemUploadUrl(String itemId) async {
    return _generateUploadUrl(
      GenerateUploadUrlRequest(
        (builder) => builder
          ..oneOf = OneOf.fromValue1(
            value: CreateItemAttachmentRequest(
              (builder) => builder..itemId = itemId,
            ),
          ),
      ),
    );
  }

  Future<Result<AttachmentModel, CollectorFailure>> generateLocationUploadUrl(String locationId) async {
    return _generateUploadUrl(
      GenerateUploadUrlRequest(
        (builder) => builder
          ..oneOf = OneOf.fromValue1(
            value: CreateLocationAttachmentRequest(
              (builder) => builder..locationId = locationId,
            ),
          ),
      ),
    );
  }

  Future<Result<AttachmentModel, CollectorFailure>> _generateUploadUrl(GenerateUploadUrlRequest request) async {
    try {
      final response = (await _attachmentApi.generateUploadUrl(generateUploadUrlRequest: request)).data;

      if (response == null) {
        return Failure(
          const InvalidResponseFailure(message: 'Failed to create attachments: response is null'),
        );
      }

      return Success(
        AttachmentMapperImpl().mapExternalToAttachmentModel(response),
      );
    } catch (e) {
      // TODO(me): ErrorHandling einbauen!
      return Failure(
        UnknownFailure(message: 'Failed to create attachments: $e'),
      );
    }
  }
}
