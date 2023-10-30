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
          color: collection.color,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                const Spacer(),
                Column(
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
                ),
                const Spacer(),
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
