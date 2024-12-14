import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'item_ownership_status.g.dart';

@HiveType(typeId: 2)
enum ItemOwnershipStatus {
  @HiveField(0)
  wishlist('WISHLIST', Icons.list, Colors.yellow),
  @HiveField(1)
  owner('OWNER', Icons.person, Colors.green),
  @HiveField(2)
  borrower('BORROWER', Icons.event_outlined, Colors.deepOrange);

  const ItemOwnershipStatus(this.name, this.icon, this.color);

  final String name;
  final IconData icon;
  final Color color;
}
