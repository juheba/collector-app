import 'package:collector/data/persistence/entities/collection_visibility.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collection_model.g.dart';

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

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String? description;
  @HiveField(3, defaultValue: defaultVisibility)
  late CollectionVisibility visibility;
}
