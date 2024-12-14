import 'package:collector/models/collection_model.dart';
import 'package:collector/presentation/pages/collections/collection_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionGridWidget extends StatelessWidget {
  const CollectionGridWidget({
    required this.collections,
    super.key,
  });
  final List<CollectionModel> collections;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class CollectionGridElementWidget extends StatelessWidget {
  const CollectionGridElementWidget({
    required this.collection,
    super.key,
  });
  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(
        CollectionDetailPageWidget.routeName,
        pathParameters: {'id': collection.id},
      ),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              collection.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: collection.visibility.foregroundColor,
              ),
            ),
            Icon(
              collection.visibility.icon,
              color: collection.visibility.color,
            ),
          ],
        ),
      ),
    );
  }
}
