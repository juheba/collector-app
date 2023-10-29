import 'package:collector/model/collection_model.dart';
import 'package:flutter/material.dart';

class CollectionGridWidget extends StatelessWidget {
  final List<CollectionModel> collections;

  const CollectionGridWidget({required this.collections, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: const BoxConstraints.expand(),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: collections.length,
          itemBuilder: (BuildContext context, int index) {
            return CollectionGridElementWidget(
              title: collections[index].title,
              color: collections[index].color,
            );
          },
        ),
      ),
    );
  }
}

class CollectionGridElementWidget extends StatelessWidget {
  final String title;
  final Color? color;

  const CollectionGridElementWidget({required this.title, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: color ?? Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
