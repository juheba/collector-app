// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_mapper.dart';

// **************************************************************************
// MapperGenerator
// **************************************************************************

class CollectionMapperImpl extends CollectionMapper {
  CollectionMapperImpl() : super();

  @override
  CollectionModel mapExternalToCollectionModel(Collection external) {
    final collectionmodel = CollectionModel(
      name: external.name,
      id: external.collectionId,
      description: external.description,
      visibility: mapExternalToCollectionVisibility(external.visibility),
    );
    return collectionmodel;
  }
}
