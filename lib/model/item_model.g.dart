// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemModelAdapter extends TypeAdapter<ItemModel> {
  @override
  final int typeId = 0;

  @override
  ItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemModel(
      id: fields[0] as String,
      title: fields[1] as String,
      type: fields[3] as ItemType,
      description: fields[2] as String?,
      isLendable: fields[4] as bool?,
      ownershipStatus: fields[5] as ItemOwnershipStatus?,
      status: fields[6] as ItemStatus?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.isLendable)
      ..writeByte(5)
      ..write(obj.ownershipStatus)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemModelAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

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
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemTypeAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

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
      other is ItemOwnershipStatusAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}

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
      other is ItemStatusAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
