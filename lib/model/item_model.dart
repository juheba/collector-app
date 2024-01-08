import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'item_model.g.dart';

@HiveType(typeId: 3)
enum ItemType {
  @HiveField(0)
  game('Game', Icons.videogame_asset, Colors.lightBlue),
  @HiveField(1)
  book('Book', Icons.book, Colors.deepOrange),
  @HiveField(2)
  movie('Movie', Icons.movie, Colors.blueGrey);

  final String name;
  final IconData icon;
  final Color color;
  const ItemType(this.name, this.icon, this.color);
}

@HiveType(typeId: 2)
enum ItemOwnershipStatus {
  @HiveField(0)
  wishlist('WISHLIST', Icons.list, Colors.yellow),
  @HiveField(1)
  owner('OWNER', Icons.person, Colors.green),
  @HiveField(2)
  borrower('BORROWER', Icons.event_outlined, Colors.deepOrange);

  final String name;
  final IconData icon;
  final Color color;
  const ItemOwnershipStatus(this.name, this.icon, this.color);
}

const defaultItemOwnershipStatus = ItemOwnershipStatus.wishlist;

@HiveType(typeId: 1)
enum ItemStatus {
  @HiveField(0)
  todo('TODO', Icons.start, Colors.blue),
  @HiveField(1)
  processing('PROCESSING', Icons.keyboard_double_arrow_right, Colors.orange),
  @HiveField(2)
  done('DONE', Icons.check_circle, Colors.green);

  final String name;
  final IconData icon;
  final Color color;
  const ItemStatus(this.name, this.icon, this.color);
}

const defaultItemStatus = ItemStatus.todo;

const defaultIsLendable = false;

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String? description;
  @HiveField(3)
  late ItemType type;
  @HiveField(4, defaultValue: defaultIsLendable)
  late bool isLendable;
  @HiveField(5, defaultValue: defaultItemOwnershipStatus)
  late ItemOwnershipStatus ownershipStatus;
  @HiveField(6, defaultValue: defaultItemStatus)
  late ItemStatus status;

  ItemModel({
    String? id,
    required this.title,
    required this.type,
    this.description,
    bool? isLendable,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
  }) {
    this.id = id == null || id.isEmpty ? const Uuid().v4() : id;
    this.isLendable = isLendable ?? defaultIsLendable;
    this.ownershipStatus = ownershipStatus ?? defaultItemOwnershipStatus;
    this.status = status ?? defaultItemStatus;
  }

  static ItemModel createDefault() {
    return ItemModel(title: 'Title', type: ItemType.book);
  }

  ItemModel update({
    String? title,
    ItemType? type,
    String? description,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
    bool? isLendable,
  }) {
    this.title = title ?? this.title;
    this.type = type ?? this.type;
    this.description = description ?? this.description;
    this.isLendable = isLendable ?? this.isLendable;
    this.ownershipStatus = ownershipStatus ?? this.ownershipStatus;
    this.status = status ?? this.status;
    return this;
  }
}
