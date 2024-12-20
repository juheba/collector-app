import 'package:collector/generated/openapi/collector-api/model/item.dart';
import 'package:collector/generated/openapi/collector-api/model/item_ownership_status_enum.dart';
import 'package:collector/generated/openapi/collector-api/model/item_status_enum.dart';
import 'package:collector/models/models.dart';
import 'package:smartstruct/smartstruct.dart';

part 'item_mapper.mapper.g.dart';

@Mapper()
abstract class ItemMapper {
  @IgnoreMapping()
  List<ItemModel> mapExternalToListItemModel(List<Item> external) {
    return external.map(mapExternalToItemModel).toList();
  }

  late ItemStatus status;

  @Mapping(source: 'itemId', target: 'id')
  @Mapping(source: mapExternalToAttachmentModel, target: 'attachment')
  @Mapping(source: mapExternalToItemType, target: 'type')
  ItemModel mapExternalToItemModel(Item external);

  @IgnoreMapping()
  static AttachmentModel mapExternalToAttachmentModel(Item external) {
    return AttachmentModel(attachmentUrl: external.attachmentUrl);
  }

  @IgnoreMapping()
  static ItemType mapExternalToItemType(Item external) => ItemType.values.firstWhere(
        (e) => e.name.toUpperCase() == external.itemType?.toUpperCase(),
        orElse: () => ItemType.undefined,
      );

  @IgnoreMapping()
  ItemOwnershipStatus mapExternalToItemOwnershipStatus(ItemOwnershipStatusEnum external) => switch (external) {
        ItemOwnershipStatusEnum.WISHLIST => ItemOwnershipStatus.wishlist,
        ItemOwnershipStatusEnum.OWNER => ItemOwnershipStatus.owner,
        ItemOwnershipStatusEnum.BORROWER => ItemOwnershipStatus.borrower,
        ItemOwnershipStatusEnum() => ItemOwnershipStatus.unknown,
      };

  @IgnoreMapping()
  ItemStatus mapExternalToItemStatus(ItemStatusEnum external) => switch (external) {
        ItemStatusEnum.TODO => ItemStatus.todo,
        ItemStatusEnum.PROCESSING => ItemStatus.processing,
        ItemStatusEnum.DONE => ItemStatus.done,
        ItemStatusEnum() => ItemStatus.unknown,
      };

  @IgnoreMapping()
  ItemOwnershipStatusEnum mapItemOwnershipStatusToExternal(ItemOwnershipStatus internal) => switch (internal) {
        ItemOwnershipStatus.wishlist => ItemOwnershipStatusEnum.WISHLIST,
        ItemOwnershipStatus.owner => ItemOwnershipStatusEnum.OWNER,
        ItemOwnershipStatus.borrower => ItemOwnershipStatusEnum.BORROWER,
        ItemOwnershipStatus.unknown => ItemOwnershipStatusEnum.WISHLIST,
      };

  @IgnoreMapping()
  ItemStatusEnum mapItemStatusToExternal(ItemStatus internal) => switch (internal) {
        ItemStatus.todo => ItemStatusEnum.TODO,
        ItemStatus.processing => ItemStatusEnum.PROCESSING,
        ItemStatus.done => ItemStatusEnum.DONE,
        ItemStatus.unknown => ItemStatusEnum.TODO,
      };

  @IgnoreMapping()
  String mapItemTypeToExternal(ItemType? internal) =>
      internal?.name.toUpperCase() ?? ItemType.undefined.name.toUpperCase();
}
