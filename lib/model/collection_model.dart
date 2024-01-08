import 'package:flutter/material.dart';

class MockCollections {
  const MockCollections();

  static List<CollectionModel> getCollections() {
    return [
      CollectionModel(id: '0', title: 'Favorite Games', color: Colors.yellow[800]),
      CollectionModel(id: '1', title: 'Classic Literature', color: Colors.red[900]),
      const CollectionModel(id: '2', title: 'Epic Movies', color: Colors.deepPurple),
      CollectionModel(id: '3', title: 'Adventure Games', color: Colors.green[600]),
      CollectionModel(id: '4', title: 'Sci-Fi Movies', color: Colors.blueGrey[700]),
      const CollectionModel(id: '5', title: 'Must-Watch Movies', color: Colors.yellowAccent),
      const CollectionModel(id: '6', title: 'Fantasy Worlds', color: Colors.tealAccent),
      const CollectionModel(id: '7', title: 'Gaming Classics', color: Colors.limeAccent),
      const CollectionModel(id: '8', title: 'Cinematic Masterpieces', color: Colors.indigoAccent),
      const CollectionModel(id: '9', title: 'Inspirational Reads', color: Colors.pinkAccent),
    ];
  }
}

class CollectionModel {
  final String id;
  final String title;
  final Color? color;

  const CollectionModel({required this.id, required this.title, this.color});
}
