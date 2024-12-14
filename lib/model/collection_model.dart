import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collection_model.g.dart';


@HiveType(typeId: 1)
enum CollectionVisibility {
  @HiveField(0)
  public(
    name: 'PUBLIC',
    icon: Icons.lock_open,
    color: Colors.blue,
  ),

  @HiveField(1)
  private(
    name: 'PRIVATE',
    icon: Icons.lock,
    color: Colors.orange,
  );

  const CollectionVisibility({
    required this.name,
    required this.icon,
    required this.color,
    this.foregroundColor,
  });

  final String name;
  final IconData icon;
  final Color color;
  final Color? foregroundColor;
}

const defaultVisibility = CollectionVisibility.public;

@HiveType(typeId: 0)
class CollectionModel extends HiveObject {
  CollectionModel({
    required this.name,
    String? id,
    this.description,
    CollectionVisibility? visibility,
  }) {
    this.id = id == null || id.isEmpty ? const Uuid().v4() : id;
    this.visibility = visibility ?? defaultVisibility;
  }

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

  factory CollectionModel.blank() => CollectionModel(name: '');

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String? description;
  @HiveField(3, defaultValue: defaultVisibility)
  late CollectionVisibility visibility;

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
}
