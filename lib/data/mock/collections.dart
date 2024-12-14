import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';

class MockCollections {
  const MockCollections();

  static List<CollectionModel> getCollections() {
    return [
      CollectionModel(id: 'collection-1', name: 'Favorite Games'),
      CollectionModel(id: 'collection-2', name: 'Epic Movies'),
      CollectionModel(id: 'collection-3', name: 'Inspirational Reads', visibility: CollectionVisibility.private),
    ];
  }
}
