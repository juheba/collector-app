// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class ItemMapperImpl extends ItemMapper {
  ItemMapperImpl() : super();

  @override
  ItemModel mapExernalToItemModel(Item external) {
    final itemmodel = ItemModel(
      id: external.itemId,
      title: external.title,
      type: ItemMapper.mapExernalToItemType(external),
      description: external.description,
      isLendable: external.isLendable,
      ownershipStatus:
          mapExernalToItemOwnershipStatus(external.ownershipStatus),
      status: mapExernalToItemStatus(external.status),
      attachment: ItemMapper.mapExernalToAttachmentModel(external),
    );
    return itemmodel;
  }
}
