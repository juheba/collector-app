import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/generated/openapi/collector-api/model/collection_visibility_enum.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:smartstruct/smartstruct.dart';

part 'collection_mapper.mapper.g.dart';

@Mapper()
abstract class CollectionMapper {
  @IgnoreMapping()
  List<CollectionModel> mapExternalToListCollectionModel(List<Collection> external) {
    return external.map(mapExternalToCollectionModel).toList();
  }

  @Mapping(source: 'collectionId', target: 'id')
  CollectionModel mapExternalToCollectionModel(Collection external);

  @IgnoreMapping()
  CollectionVisibility mapExternalToCollectionVisibility(
    CollectionVisibilityEnum external,
  ) =>
      switch (external) {
        CollectionVisibilityEnum.PRIVATE => CollectionVisibility.private,
        CollectionVisibilityEnum.PUBLIC => CollectionVisibility.public,
        _ => CollectionVisibility.private,
      };

  @IgnoreMapping()
  CollectionVisibilityEnum mapCollectionVisibilityToExternal(CollectionVisibility internal) => switch (internal) {
        CollectionVisibility.private => CollectionVisibilityEnum.PRIVATE,
        CollectionVisibility.public => CollectionVisibilityEnum.PUBLIC,
      };
}
