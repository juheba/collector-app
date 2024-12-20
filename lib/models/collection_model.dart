import 'package:collector/models/collection_visibility.dart';
import 'package:uuid/uuid.dart';

const defaultVisibility = CollectionVisibility.private;

class CollectionModel {
  CollectionModel({
    required this.id,
    required this.name,
    this.description,
    this.visibility = defaultVisibility,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['collectionId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      visibility: CollectionVisibility.values.firstWhere(
        (v) => v.name == (json['visibility'] as String).toUpperCase(),
        orElse: () => defaultVisibility,
      ),
    );
  }

  factory CollectionModel.blank() => CollectionModel(
        id: '',
        name: '',
      );

  final String id;
  final String name;
  final String? description;
  final CollectionVisibility visibility;

  CollectionModel copyWith({
    String? name,
    CollectionVisibility? visibility,
    String? description,
  }) =>
      CollectionModel(
        id: id,
        name: name ?? this.name,
        description: description ?? this.description,
        visibility: visibility ?? this.visibility,
      );

  /// overrides == operator because of an issue in MultiSelectDialog, see https://github.com/CHB61/multi_select_flutter/issues/11#issuecomment-769862675
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CollectionModel && runtimeType == other.runtimeType && name == other.name;

  /// overrides get hashcode because of an issue in MultiSelectDialog, see https://github.com/CHB61/multi_select_flutter/issues/11#issuecomment-769862675
  @override
  int get hashCode => name.hashCode;
}
