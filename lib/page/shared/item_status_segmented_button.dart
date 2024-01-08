import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class ItemStatusSingleChoiceSegmentedButton extends StatefulWidget {
  const ItemStatusSingleChoiceSegmentedButton({
    super.key,
    this.selectedStatus,
    required this.statusChanged,
  });

  final ItemStatus? selectedStatus;
  final Function(ItemStatus status) statusChanged;

  @override
  State<ItemStatusSingleChoiceSegmentedButton> createState() => _ItemStatusSingleChoiceSegmentedButtonState();
}

class _ItemStatusSingleChoiceSegmentedButtonState extends State<ItemStatusSingleChoiceSegmentedButton> {
  late ItemStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus ?? defaultItemStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ItemStatus>(
      segments: ItemStatus.values
          .map(
            (status) => ButtonSegment(
              value: status,
              label: Text(status.name),
              icon: Icon(
                status.icon,
                color: status.color,
              ),
            ),
          )
          .toList(),
      selected: {selectedStatus},
      onSelectionChanged: (newSelection) => setState(() {
        // By default there is only a single segment that can be selected at one time,
        // so its value is always the first item in the selected set.
        selectedStatus = newSelection.first;
        widget.statusChanged(selectedStatus);
      }),
    );
  }
}
