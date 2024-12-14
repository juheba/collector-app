// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 3;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.game;
      case 1:
        return ItemType.book;
      case 2:
        return ItemType.movie;
      case 3:
        return ItemType.undefined;
      default:
        return ItemType.game;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.game:
        writer.writeByte(0);
        break;
      case ItemType.book:
        writer.writeByte(1);
        break;
      case ItemType.movie:
        writer.writeByte(2);
        break;
      case ItemType.undefined:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
