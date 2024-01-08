import 'package:collector/model/collection_model.dart';
import 'package:collector/page/shared/item_list.dart';
import 'package:flutter/material.dart';

class CollectionDetailPageWidget extends StatelessWidget {
  final CollectionModel collection;

  const CollectionDetailPageWidget({
    required this.collection,
    super.key,
  });

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
        const ItemsListWidget(),
      ],
    );
  }
}
