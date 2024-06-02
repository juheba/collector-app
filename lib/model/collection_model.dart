import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collection_model.g.dart';

class MockCollections {
  const MockCollections();

  static List<CollectionModel> getCollections() {
    return [
      CollectionModel(name: 'Favorite Games', visibility: CollectionVisibility.public),
      CollectionModel(name: 'Epic Movies', visibility: CollectionVisibility.public),
      CollectionModel(name: 'Inspirational Reads', visibility: CollectionVisibility.private),
    ];
  }
}

/*
class CollectionModel {
  const CollectionModel({required this.id, required this.title, this.color});
  final String id;
  final String title;
  final Color? color;
}*/

@HiveType(typeId: 1)
enum CollectionVisibility {
  @HiveField(0)
  public('PUBLIC', Icons.lock_open, Colors.blue),
  @HiveField(1)
  private('PRIVATE', Icons.lock, Colors.orange);

  const CollectionVisibility(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
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

  factory CollectionModel.blank() => CollectionModel(name: '');

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String? description;
  @HiveField(3, defaultValue: defaultVisibility)
  late CollectionVisibility visibility;

  CollectionModel update({
    String? name,
    CollectionVisibility? visibility,
    String? description,
  }) {
    this.name = name ?? this.name;
    this.description = description ?? this.description;
    this.visibility = visibility ?? this.visibility;
    return this;
  }
}
