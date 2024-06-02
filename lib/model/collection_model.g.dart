// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CollectionModelAdapter extends TypeAdapter<CollectionModel> {
  @override
  final int typeId = 0;

  @override
  CollectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CollectionModel(
      name: fields[1] as String,
      id: fields[0] as String?,
      description: fields[2] as String?,
      visibility: fields[3] == null
          ? CollectionVisibility.public
          : fields[3] as CollectionVisibility?,
    );
  }

  @override
  void write(BinaryWriter writer, CollectionModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.visibility);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CollectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
