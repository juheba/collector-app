import 'package:collector/models/item_model.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class ItemStatusSingleChoiceSegmentedButton extends StatefulWidget {
  const ItemStatusSingleChoiceSegmentedButton({
    required this.statusChanged,
    required this.selectedStatus,
    super.key,
  });

  final ItemStatus selectedStatus;
  final void Function(ItemStatus status) statusChanged;

  @override
  State<ItemStatusSingleChoiceSegmentedButton> createState() => _ItemStatusSingleChoiceSegmentedButtonState();
}

class _ItemStatusSingleChoiceSegmentedButtonState extends State<ItemStatusSingleChoiceSegmentedButton> {
  late ItemStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selectedStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ItemStatus>(
      segments: ItemStatus.values
          .map(
            (status) => ButtonSegment(
              value: status,
              label: Text(status.displayName(context)),
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
