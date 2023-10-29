import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class MediaItem {
  final String title;
  final String subtitle;
  final String type; // Video Game, Blu-ray, Book
  final IconData iconData;

  MediaItem(this.title, this.subtitle, this.type, this.iconData);
}

class ItemsListWidget extends StatelessWidget {
  final List<ItemModel> items;

  const ItemsListWidget({required this.items, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemListElementWidget(item: items[index]);
        },
      ),
    );
  }
}

class ItemListElementWidget extends StatelessWidget {
  final ItemModel item;

  const ItemListElementWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5.0,
      child: ListTile(
        leading: Icon(item.type.icon, size: 50.0, color: item.type.color),
        title: Text(item.title, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        subtitle: const Text('fixer text'),
        trailing: Text(item.type.name, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}
