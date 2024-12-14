// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemStatusAdapter extends TypeAdapter<ItemStatus> {
  @override
  final int typeId = 1;

  @override
  ItemStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemStatus.todo;
      case 1:
        return ItemStatus.processing;
      case 2:
        return ItemStatus.done;
      default:
        return ItemStatus.todo;
    }
  }

  @override
  void write(BinaryWriter writer, ItemStatus obj) {
    switch (obj) {
      case ItemStatus.todo:
        writer.writeByte(0);
        break;
      case ItemStatus.processing:
        writer.writeByte(1);
        break;
      case ItemStatus.done:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
