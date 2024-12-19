import 'package:collector/models/attachment_model.dart';

class LocationModel {
  LocationModel({
    required this.id,
    required this.name,
    this.description,
    this.attachment,
  });

  factory LocationModel.blank() => LocationModel(
        id: '',
        name: '',
        description: '',
      );

  final String id;
  final String name;
  final String? description;
  final AttachmentModel? attachment;

  LocationModel copyWith({
    String? name,
    String? description,
    AttachmentModel? attachment,
  }) =>
      LocationModel(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        attachment: attachment ?? this.attachment,
      );
}
