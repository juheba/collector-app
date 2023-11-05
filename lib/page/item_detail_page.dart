import 'package:collector/model/item_model.dart';
import 'package:collector/page/shared/items_widget.dart';
import 'package:flutter/material.dart';

class ItemDetailPageWidget extends StatelessWidget {
  final ItemModel item;

  const ItemDetailPageWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemListElementWidget(item: item),
      ],
    );
  }
}
