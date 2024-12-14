class AttachmentModel {
  AttachmentModel({
    this.uploadUrl,
    this.attachmentUrl,
  });

  /// The URL to upload the attachment
  final String? uploadUrl;

  /// The URL to load the attachment
  final String? attachmentUrl;

  AttachmentModel copyWith({
    String? uploadUrl,
    String? attachmentUrl,
  }) {
    return AttachmentModel(
      uploadUrl: uploadUrl ?? this.uploadUrl,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
    );
  }
}
