import 'package:collector/generated/openapi/collector-api/model/collection.dart';
import 'package:collector/generated/openapi/collector-api/model/collection_visibility_enum.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:smartstruct/smartstruct.dart';

part 'collection_mapper.mapper.g.dart';

@Mapper()
abstract class CollectionMapper {
  @IgnoreMapping()
  List<CollectionModel> mapExernalToListCollectionModel(List<Collection> external) {
    return external.map(mapExernalToCollectionModel).toList();
  }

  @Mapping(source: 'collectionId', target: 'id')
  CollectionModel mapExernalToCollectionModel(Collection external);

  @IgnoreMapping()
  CollectionVisibility mapExernalToCollectionVisibility(
    CollectionVisibilityEnum external,
  ) =>
      switch (external) {
        CollectionVisibilityEnum.PRIVATE => CollectionVisibility.private,
        CollectionVisibilityEnum.PUBLIC => CollectionVisibility.public,
        _ => CollectionVisibility.private,
      };
}
