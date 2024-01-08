import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemStatusSingleChoiceSegmentedButton extends StatefulWidget {
  const ItemStatusSingleChoiceSegmentedButton({super.key, this.selectedStatus, required this.statusChanged});
  final ItemStatus? selectedStatus;
  final Function(ItemStatus status) statusChanged;

  @override
  State<ItemStatusSingleChoiceSegmentedButton> createState() => _ItemStatusSingleChoiceSegmentedButtonState();
}

class _ItemStatusSingleChoiceSegmentedButtonState extends State<ItemStatusSingleChoiceSegmentedButton> {
  late ItemStatus view;

  @override
  void initState() {
    super.initState();
    view = widget.selectedStatus ?? defaultItemStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ItemStatus>(
      segments: <ButtonSegment<ItemStatus>>[
        ButtonSegment<ItemStatus>(
          value: ItemStatus.todo,
          label: Text(ItemStatus.todo.name),
          icon: Icon(
            ItemStatus.todo.icon,
            color: ItemStatus.todo.color,
          ),
        ),
        ButtonSegment<ItemStatus>(
          value: ItemStatus.processing,
          label: Text(ItemStatus.processing.name),
          icon: Icon(
            ItemStatus.processing.icon,
            color: ItemStatus.processing.color,
          ),
        ),
        ButtonSegment<ItemStatus>(
          value: ItemStatus.done,
          label: Text(ItemStatus.done.name),
          icon: Icon(
            ItemStatus.done.icon,
            color: ItemStatus.done.color,
          ),
        ),
      ],
      selected: <ItemStatus>{view},
      onSelectionChanged: (Set<ItemStatus> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          view = newSelection.first;
          widget.statusChanged(view);
        });
      },
    );
  }
}
