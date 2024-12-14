import 'package:collector/model/collection_model.dart';

class MockCollections {
  const MockCollections();

  static List<CollectionModel> getCollections() {
    return [
      CollectionModel(name: 'Favorite Games', visibility: CollectionVisibility.public),
      CollectionModel(name: 'Epic Movies', visibility: CollectionVisibility.public),
      CollectionModel(name: 'Inspirational Reads', visibility: CollectionVisibility.private),
    ];
  }
}