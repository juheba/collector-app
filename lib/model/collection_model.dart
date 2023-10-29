import 'package:flutter/material.dart';

class MockCollections {
  const MockCollections();

  static List<CollectionModel> getCollections() {
    return [
      CollectionModel(title: 'Favorite Games', color: Colors.yellow[800]),
      CollectionModel(title: 'Classic Literature', color: Colors.red[900]),
      const CollectionModel(title: 'Epic Movies', color: Colors.deepPurple),
      CollectionModel(title: 'Adventure Games', color: Colors.green[600]),
      CollectionModel(title: 'Sci-Fi Movies', color: Colors.blueGrey[700]),
      const CollectionModel(title: 'Must-Watch Movies', color: Colors.yellowAccent),
      const CollectionModel(title: 'Fantasy Worlds', color: Colors.tealAccent),
      const CollectionModel(title: 'Gaming Classics', color: Colors.limeAccent),
      const CollectionModel(title: 'Cinematic Masterpieces', color: Colors.indigoAccent),
      const CollectionModel(title: 'Inspirational Reads', color: Colors.pinkAccent),
    ];
  }
}

class CollectionModel {
  final String title;
  final Color? color;

  const CollectionModel({required this.title, this.color});
}

/*

Map<CollectionModel, List<ItemModel>> collectionItems = {
  exampleCollections[0]: [
    mockData[0],  // The Legend of Zelda
    mockData[1],  // Super Mario Bros.
    mockData[2],  // Halo: Combat Evolved
  ],
  exampleCollections[1]: [
    mockData[3],  // 1984
    mockData[9],  // The Great Gatsby
    mockData[10], // The Hobbit
  ],
  exampleCollections[2]: [
    mockData[6],  // Inception
    mockData[7],  // The Matrix
    mockData[13], // Interstellar
  ],
  exampleCollections[3]: [
    mockData[2],  // Halo: Combat Evolved
    mockData[0],  // The Legend of Zelda
  ],
  exampleCollections[4]: [
    mockData[8],  // Pulp Fiction
    mockData[12], // Star Wars: A New Hope
    mockData[14], // The Dark Knight
  ],
};


 */