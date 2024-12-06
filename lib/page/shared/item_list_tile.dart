import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemListElementWidget extends StatelessWidget {
  const ItemListElementWidget({
    required this.item,
    this.onTap,
    this.isSelectionModeActive = false,
    this.isSelected = false,
    this.selectionChanged,
    super.key,
  });

  final ItemModel item;
  final void Function()? onTap;

  final bool isSelectionModeActive;
  final bool isSelected;
  final void Function(bool isSelected)? selectionChanged;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      item.type?.icon,
      size: 50,
      color: item.type?.color,
    );

    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 5,
      child: ListTile(
        minVerticalPadding: 24,
        onTap: isSelectionModeActive ? null : onTap,
        leading: isSelectionModeActive
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: isSelected,
                    onChanged: (value) => selectionChanged?.call(value ?? isSelected),
                  ),
                  icon,
                ],
              )
            : icon,
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: (item.description != null)
            ? Text(
                item.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Text(
          item.type?.name ?? '',
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
