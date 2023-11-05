import 'package:flutter/material.dart';

class MockItems {
  const MockItems();

  static List<ItemModel> getItems() {
    return [
      ItemModel(id: '0', title: 'The Legend of Zelda', type: ItemType.game),
      ItemModel(id: '1', title: 'Super Mario Bros.', type: ItemType.game),
      ItemModel(id: '2', title: 'Halo: Combat Evolved', type: ItemType.game),
      ItemModel(id: '3', title: '1984', type: ItemType.book),
      ItemModel(id: '4', title: 'To Kill a Mockingbird', type: ItemType.book),
      ItemModel(id: '5', title: 'Harry Potter and the Philosopher\'s Stone', type: ItemType.book),
      ItemModel(id: '6', title: 'Inception', type: ItemType.movie),
      ItemModel(id: '7', title: 'The Matrix', type: ItemType.movie),
      ItemModel(id: '8', title: 'Pulp Fiction', type: ItemType.movie),
      ItemModel(id: '9', title: 'The Great Gatsby', type: ItemType.book),
      ItemModel(id: '10', title: 'The Hobbit', type: ItemType.book),
      ItemModel(id: '11', title: 'The Lord of the Rings', type: ItemType.book),
      ItemModel(id: '12', title: 'Star Wars: A New Hope', type: ItemType.movie),
      ItemModel(id: '13', title: 'Interstellar', type: ItemType.movie),
      ItemModel(id: '14', title: 'The Dark Knight', type: ItemType.movie),
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

enum ItemOwnershipStatus {
  wishlist('WISHLIST', Icons.list, Colors.yellow),
  owner('OWNER', Icons.person, Colors.green),
  borrower('BORROWER', Icons.event_outlined, Colors.deepOrange);

  final String name;
  final IconData icon;
  final Color color;
  const ItemOwnershipStatus(this.name, this.icon, this.color);
}

enum ItemStatus {
  todo('TODO', Icons.start, Colors.blue),
  processing('PROCESSING', Icons.keyboard_double_arrow_right, Colors.orange),
  done('DONE', Icons.check_circle, Colors.green);

  final String name;
  final IconData icon;
  final Color color;
  const ItemStatus(this.name, this.icon, this.color);
}

class ItemModel {
  final String id;
  final String title;
  final String? description;
  final ItemType type;
  bool? isLendable = false;
  ItemOwnershipStatus? ownershipStatus = ItemOwnershipStatus.wishlist;
  ItemStatus? status = ItemStatus.todo;

  ItemModel({
    required this.id,
    required this.title,
    required this.type,
    this.description,
    this.isLendable,
    this.ownershipStatus,
    this.status,
  });
}
