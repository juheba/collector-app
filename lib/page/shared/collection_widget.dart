import 'package:collector/model/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              collection: collections[index],
            );
          },
        ),
      ),
    );
  }
}

class CollectionGridElementWidget extends StatelessWidget {
  final CollectionModel collection;

  const CollectionGridElementWidget({required this.collection, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).goNamed(
          'collection-details',
          pathParameters: {'id': collection.id},
        );
      },
      child: Container(
          padding: const EdgeInsets.all(8),
          color: collection.color ?? Colors.teal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                collection.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )),
    );
  }
}
