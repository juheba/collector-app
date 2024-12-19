import 'package:collector/models/attachment_model.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/models/item_type.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ItemModel {
  ItemModel({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.isLendable,
    required this.ownershipStatus,
    required this.status,
    required this.attachment,
    required this.locationId,
  });

  factory ItemModel.blank() => ItemModel(
        id: '',
        title: '',
        type: null,
        description: '',
        isLendable: false,
        ownershipStatus: ItemOwnershipStatus.wishlist,
        status: ItemStatus.todo,
        attachment: null,
        locationId: null,
      );

  final String id;
  final String title;
  final String? description;
  final ItemType? type;
  final bool isLendable;
  final ItemOwnershipStatus ownershipStatus;
  final ItemStatus status;
  final AttachmentModel? attachment;
  final String? locationId;

  ItemModel copyWith({
    String? title,
    ItemType? type,
    String? description,
    ItemOwnershipStatus? ownershipStatus,
    ItemStatus? status,
    bool? isLendable,
    AttachmentModel? attachment,
    String? locationId,
  }) =>
      ItemModel(
        id: id,
        title: title ?? this.title,
        type: type ?? this.type,
        description: description ?? this.description,
        isLendable: isLendable ?? this.isLendable,
        ownershipStatus: ownershipStatus ?? this.ownershipStatus,
        status: status ?? this.status,
        attachment: attachment ?? this.attachment,
        locationId: locationId ?? this.locationId,
      );
}
