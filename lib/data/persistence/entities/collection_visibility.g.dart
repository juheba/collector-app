// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_visibility.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionVisibilityAdapter extends TypeAdapter<CollectionVisibility> {
  @override
  final int typeId = 1;

  @override
  CollectionVisibility read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CollectionVisibility.public;
      case 1:
        return CollectionVisibility.private;
      default:
        return CollectionVisibility.public;
    }
  }

  @override
  void write(BinaryWriter writer, CollectionVisibility obj) {
    switch (obj) {
      case CollectionVisibility.public:
        writer.writeByte(0);
        break;
      case CollectionVisibility.private:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionVisibilityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
