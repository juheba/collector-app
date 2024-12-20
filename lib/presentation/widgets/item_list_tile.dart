import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/utils/item_type_utils.dart';
import 'package:flutter/material.dart';

class ItemListTile extends StatelessWidget {
  const ItemListTile({
    required this.item,
    this.isSelected = false,
    this.isSelectionModeActive = false,
    this.onTap,
    this.selectionChanged,
    super.key,
  });

  /// The item to be displayed.
  final ItemModel item;

  /// Whether the item is selected.
  final bool isSelected;

  /// Callback that is called when the item is tapped.
  final void Function()? onTap;

  /// Whether multiple selection mode is active.
  final bool isSelectionModeActive;

  /// Callback that is called when the selection state of the item changes.
  final void Function(bool isSelected)? selectionChanged;

  @override
  Widget build(BuildContext context) {
    final typeIcon = Icon(
      item.type?.icon,
      size: 35,
      color: item.type?.color,
    );

    final itemImage = item.attachment?.attachmentUrl != null
        ? Image.network(
            item.attachment!.attachmentUrl!,
            width: 50,
          )
        : null;

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
                  if (itemImage != null) itemImage,
                ],
              )
            : itemImage,
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
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            typeIcon,
            Text(
              item.type?.displayName(context) ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
