import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'item_status.g.dart';

@HiveType(typeId: 1)
enum ItemStatus {
  @HiveField(0)
  todo('TODO', Icons.start, Colors.blue),
  @HiveField(1)
  processing('PROCESSING', Icons.keyboard_double_arrow_right, Colors.orange),
  @HiveField(2)
  done('DONE', Icons.check_circle, Colors.green);

  const ItemStatus(this.name, this.icon, this.color);
  final String name;
  final IconData icon;
  final Color color;
}
