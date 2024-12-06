// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class CollectionMapperImpl extends CollectionMapper {
  CollectionMapperImpl() : super();

  @override
  CollectionModel mapExernalToCollectionModel(Collection external) {
    final collectionmodel = CollectionModel(
      name: external.name,
      id: external.collectionId,
      description: external.description,
      visibility: mapExernalToCollectionVisibility(external.visibility),
    );
    return collectionmodel;
  }
}
