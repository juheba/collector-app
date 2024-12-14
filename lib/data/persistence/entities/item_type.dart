import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'item_type.g.dart';

@HiveType(typeId: 3)
enum ItemType {
  @HiveField(0)
  game('Game', Icons.videogame_asset, Colors.lightBlue),
  @HiveField(1)
  book('Book', Icons.book, Colors.deepOrange),
  @HiveField(2)
  movie('Movie', Icons.movie, Color.fromARGB(255, 212, 209, 52)),
  @HiveField(3)
  undefined('Undefined', Icons.help_center, Color.fromARGB(255, 75, 86, 87));

  const ItemType(
    this.name,
    this.icon,
    this.color,
  );

  final String name;
  final IconData icon;
  final Color color;
}
