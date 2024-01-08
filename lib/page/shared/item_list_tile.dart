import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemListElementWidget extends StatelessWidget {
  const ItemListElementWidget({
    required this.item,
    super.key,
  });
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      child: ListTile(
        leading: Icon(
          item.type.icon,
          size: 50,
          color: item.type.color,
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text('fixer text'),
        trailing: Text(
          item.type.name,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
