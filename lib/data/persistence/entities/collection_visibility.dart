import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'collection_visibility.g.dart';

@HiveType(typeId: 1)
enum CollectionVisibility {
  @HiveField(0)
  public(
    name: 'PUBLIC',
    icon: Icons.lock_open,
    color: Colors.blue,
  ),

  @HiveField(1)
  private(
    name: 'PRIVATE',
    icon: Icons.lock,
    color: Colors.orange,
  );

  const CollectionVisibility({
    required this.name,
    required this.icon,
    required this.color,
    this.foregroundColor,
  });

  final String name;
  final IconData icon;
  final Color color;
  final Color? foregroundColor;
}
