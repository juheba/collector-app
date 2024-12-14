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
      title: fields[1] as String,
      type: fields[3] as ItemType?,
      id: fields[0] as String?,
      description: fields[2] as String?,
      isLendable: fields[4] == null ? false : fields[4] as bool?,
      ownershipStatus: fields[5] == null
          ? ItemOwnershipStatus.wishlist
          : fields[5] as ItemOwnershipStatus?,
      status: fields[6] == null ? ItemStatus.todo : fields[6] as ItemStatus?,
      attachment: fields[7] as AttachmentModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.attachment);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
