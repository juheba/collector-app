import 'package:collector/model/item_model.dart';
import 'package:collector/page/item_detail_page.dart';
import 'package:collector/page/items_page.dart';
import 'package:collector/page/shared/item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ItemsListWidget extends StatefulWidget {
  const ItemsListWidget({
    required this.items,
    required this.isSelectionModeActive,
    super.key,
  });

  final List<ItemModel> items;
  final bool isSelectionModeActive;

  @override
  State<ItemsListWidget> createState() => _ItemsListWidgetState();
}

class _ItemsListWidgetState extends State<ItemsListWidget> {
  final _selectedItems = List<ItemModel>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];

        return ItemListElementWidget(
          item: item,
          onTap: () => context.goNamed(
            ItemDetailPageWidget.routeName,
            pathParameters: {'id': item.id},
          ),
          isSelectionModeActive: widget.isSelectionModeActive,
          isSelected: _selectedItems.contains(item),
          selectionChanged: (isSelected) => setState(
            () => isSelected ? _selectedItems.add(item) : _selectedItems.remove(item),
          ),
        );
      },
    );
  }
}
