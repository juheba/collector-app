import 'package:collector/data/persistence/entities/entities.dart';
import 'package:collector/models/attachment_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


part 'item_model.g.dart';

const defaultItemOwnershipStatus = ItemOwnershipStatus.wishlist;

const defaultItemStatus = ItemStatus.todo;

const defaultIsLendable = false;

@HiveType(typeId: 0)
class ItemModel extends HiveObject {
  ItemModel({
    required this.title,
    this.type,
    String? id,
    this.description,
    bool? isLendable,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
    this.attachment,
  }) {
//    this.id = id == null || id.isEmpty ? const Uuid().v4() : id;
    this.id = id == null || id.isEmpty ? '' : id;
    this.isLendable = isLendable ?? defaultIsLendable;
    this.ownershipStatus = ownershipStatus ?? defaultItemOwnershipStatus;
    this.status = status ?? defaultItemStatus;
  }

  factory ItemModel.blank() => ItemModel(title: '', type: ItemType.undefined);

  @HiveField(0)
  late String id;
  @HiveField(1)
  late String title;
  @HiveField(2)
  late String? description;
  @HiveField(3)
  late ItemType? type;
  @HiveField(4, defaultValue: defaultIsLendable)
  late bool isLendable;
  @HiveField(5, defaultValue: defaultItemOwnershipStatus)
  late ItemOwnershipStatus ownershipStatus;
  @HiveField(6, defaultValue: defaultItemStatus)
  late ItemStatus status;
  @HiveField(7)
  late AttachmentModel? attachment;
}
