import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class OwnershipStatusSingleChoiceSegmentedButton extends StatefulWidget {
  const OwnershipStatusSingleChoiceSegmentedButton({
    super.key,
    this.selected,
    required this.statusChanged,
  });

  final ItemOwnershipStatus? selected;
  final Function(ItemOwnershipStatus status) statusChanged;

  @override
  State<OwnershipStatusSingleChoiceSegmentedButton> createState() => _OwnershipStatusSingleChoiceSegmentedButtonState();
}

class _OwnershipStatusSingleChoiceSegmentedButtonState extends State<OwnershipStatusSingleChoiceSegmentedButton> {
  late ItemOwnershipStatus selectedStatus;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.selected ?? defaultItemOwnershipStatus;
  }

  void resetState() {
    setState(() {
      selectedStatus = defaultItemOwnershipStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ItemOwnershipStatus>(
      segments: ItemOwnershipStatus.values
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
