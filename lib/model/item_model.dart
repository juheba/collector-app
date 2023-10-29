import 'package:flutter/material.dart';

class MockItems {
  const MockItems();

  static List<ItemModel> getItems() {
    return [
      const ItemModel(title: 'The Legend of Zelda', type: ItemType.game),
      const ItemModel(title: 'Super Mario Bros.', type: ItemType.game),
      const ItemModel(title: 'Halo: Combat Evolved', type: ItemType.game),
      const ItemModel(title: '1984', type: ItemType.book),
      const ItemModel(title: 'To Kill a Mockingbird', type: ItemType.book),
      const ItemModel(title: 'Harry Potter and the Philosopher\'s Stone', type: ItemType.book),
      const ItemModel(title: 'Inception', type: ItemType.movie),
      const ItemModel(title: 'The Matrix', type: ItemType.movie),
      const ItemModel(title: 'Pulp Fiction', type: ItemType.movie),
      const ItemModel(title: 'The Great Gatsby', type: ItemType.book),
      const ItemModel(title: 'The Hobbit', type: ItemType.book),
      const ItemModel(title: 'The Lord of the Rings', type: ItemType.book),
      const ItemModel(title: 'Star Wars: A New Hope', type: ItemType.movie),
      const ItemModel(title: 'Interstellar', type: ItemType.movie),
      const ItemModel(title: 'The Dark Knight', type: ItemType.movie),
    ];
  }
}

enum ItemType {
  game('Game', Icons.videogame_asset, Colors.lightBlue),
  book('Book', Icons.book, Colors.deepOrange),
  movie('Movie', Icons.movie, Colors.blueGrey);

  final String name;
  final IconData icon;
  final Color color;
  const ItemType(this.name, this.icon, this.color);
}

class ItemModel {
  final String title;
  final ItemType type;

  const ItemModel({required this.title, required this.type});
}
