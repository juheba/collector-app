import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class OwnershipStatusSingleChoiceSegmentedButton extends StatefulWidget {
  const OwnershipStatusSingleChoiceSegmentedButton(
      {super.key, this.selectedOwnership, required this.ownershipStatusChanged});
  final ItemOwnershipStatus? selectedOwnership;
  final Function(ItemOwnershipStatus status) ownershipStatusChanged;

  @override
  State<OwnershipStatusSingleChoiceSegmentedButton> createState() => _OwnershipStatusSingleChoiceSegmentedButtonState();
}

class _OwnershipStatusSingleChoiceSegmentedButtonState extends State<OwnershipStatusSingleChoiceSegmentedButton> {
  late ItemOwnershipStatus view;

  @override
  void initState() {
    super.initState();
    view = widget.selectedOwnership ?? defaultItemOwnershipStatus;
  }

  void resetState() {
    setState(() {
      view = defaultItemOwnershipStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ItemOwnershipStatus>(
      segments: <ButtonSegment<ItemOwnershipStatus>>[
        ButtonSegment<ItemOwnershipStatus>(
          value: ItemOwnershipStatus.wishlist,
          label: Text(ItemOwnershipStatus.wishlist.name),
          icon: Icon(
            ItemOwnershipStatus.wishlist.icon,
            color: ItemOwnershipStatus.wishlist.color,
          ),
        ),
        ButtonSegment<ItemOwnershipStatus>(
          value: ItemOwnershipStatus.owner,
          label: Text(ItemOwnershipStatus.owner.name),
          icon: Icon(
            ItemOwnershipStatus.owner.icon,
            color: ItemOwnershipStatus.owner.color,
          ),
        ),
        ButtonSegment<ItemOwnershipStatus>(
          value: ItemOwnershipStatus.borrower,
          label: Text(ItemOwnershipStatus.borrower.name),
          icon: Icon(
            ItemOwnershipStatus.borrower.icon,
            color: ItemOwnershipStatus.borrower.color,
          ),
        ),
      ],
      selected: <ItemOwnershipStatus>{view},
      onSelectionChanged: (Set<ItemOwnershipStatus> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          view = newSelection.first;
          widget.ownershipStatusChanged(view);
        });
      },
    );
  }
}
