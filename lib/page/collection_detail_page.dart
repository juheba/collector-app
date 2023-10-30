import 'package:collector/model/collection_model.dart';
import 'package:collector/model/item_model.dart';
import 'package:collector/page/shared/items_widget.dart';
import 'package:flutter/material.dart';

class CollectionDetailPageWidget extends StatelessWidget {
  final CollectionModel collection;

  const CollectionDetailPageWidget({required this.collection, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(collection.title),
                  ],
                ),
              ],
            ),
          ),
        ),
        ItemsListWidget(items: [
          MockItems.getItems()[3],
          MockItems.getItems()[1],
          MockItems.getItems()[7],
        ]),
      ],
    );
  }
}
