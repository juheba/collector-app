// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class ItemMapperImpl extends ItemMapper {
  ItemMapperImpl() : super();

  @override
  ItemModel mapExternalToItemModel(Item external) {
    final itemmodel = ItemModel(
      id: external.itemId,
      title: external.title,
      type: ItemMapper.mapExternalToItemType(external),
      description: external.description,
      isLendable: external.isLendable,
      ownershipStatus: mapExternalToItemOwnershipStatus(external.ownershipStatus),
      status: mapExternalToItemStatus(external.status),
      attachment: ItemMapper.mapExternalToAttachmentModel(external),
      locationId: external.locationId,
    );
    return itemmodel;
  }
}
