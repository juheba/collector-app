// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class AttachmentMapperImpl extends AttachmentMapper {
  AttachmentMapperImpl() : super();

  @override
  AttachmentModel mapExernalToAttachmentModel(AttachmentURLResponse external) {
    final attachmentmodel = AttachmentModel(uploadUrl: external.uploadUrl);
    return attachmentmodel;
  }
}
