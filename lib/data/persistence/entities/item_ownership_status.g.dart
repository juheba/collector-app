// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_ownership_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemOwnershipStatusAdapter extends TypeAdapter<ItemOwnershipStatus> {
  @override
  final int typeId = 2;

  @override
  ItemOwnershipStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemOwnershipStatus.wishlist;
      case 1:
        return ItemOwnershipStatus.owner;
      case 2:
        return ItemOwnershipStatus.borrower;
      default:
        return ItemOwnershipStatus.wishlist;
    }
  }

  @override
  void write(BinaryWriter writer, ItemOwnershipStatus obj) {
    switch (obj) {
      case ItemOwnershipStatus.wishlist:
        writer.writeByte(0);
        break;
      case ItemOwnershipStatus.owner:
        writer.writeByte(1);
        break;
      case ItemOwnershipStatus.borrower:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemOwnershipStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
