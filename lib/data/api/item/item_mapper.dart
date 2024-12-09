import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/generated/openapi/collector-api/model/collection_visibility_enum.dart';
import 'package:collector/generated/openapi/collector-api/model/create_item_request.dart';
import 'package:collector/generated/openapi/collector-api/model/item.dart';
import 'package:collector/generated/openapi/collector-api/model/item_ownership_status_enum.dart';
import 'package:collector/generated/openapi/collector-api/model/item_status_enum.dart';
import 'package:collector/generated/openapi/collector-api/model/update_item_request.dart';
import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:smartstruct/smartstruct.dart';

part 'item_mapper.mapper.g.dart';

@Mapper()
abstract class ItemMapper {
  @IgnoreMapping()
  List<ItemModel> mapExernalToListItemModel(List<Item> external) {
    return external.map(mapExernalToItemModel).toList();
  }

  late ItemStatus status;

  @Mapping(source: 'itemId', target: 'id')
  @Mapping(source: mapExernalToItemType, target: 'type')
  ItemModel mapExernalToItemModel(Item external);

  @IgnoreMapping()
  static ItemType mapExernalToItemType(Item external) => external.itemType == null
      ? ItemType.undefined
      : ItemType.values.firstWhere(
          (type) => type.name == external.itemType,
          orElse: () => ItemType.undefined,
        );

  @IgnoreMapping()
  ItemOwnershipStatus mapExernalToItemOwnershipStatus(ItemOwnershipStatusEnum external) =>
      ItemOwnershipStatus.values.byName(external.name.toLowerCase());

  @IgnoreMapping()
  ItemStatus mapExernalToItemStatus(ItemStatusEnum external) => ItemStatus.values.byName(external.name.toLowerCase());

  @IgnoreMapping()
  ItemOwnershipStatusEnum mapItemOwnershipStatusToExternal(ItemOwnershipStatus internal) =>
      ItemOwnershipStatusEnum.values.firstWhere((element) => element.name == internal.name);

  @IgnoreMapping()
  ItemStatusEnum mapItemStatusToExternal(ItemStatus internal) =>
      ItemStatusEnum.values.firstWhere((element) => element.name == internal.name);
}
