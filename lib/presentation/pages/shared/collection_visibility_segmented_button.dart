import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:collector/presentation/utils/utils.dart';
import 'package:flutter/material.dart';

class CollectionVisibilitySingleChoiceSegmentedButton extends StatefulWidget {
  const CollectionVisibilitySingleChoiceSegmentedButton({
    required this.visibilityChanged,
    required this.selected,
    super.key,
  });

  final CollectionVisibility selected;
  final void Function(CollectionVisibility visibility) visibilityChanged;

  @override
  State<CollectionVisibilitySingleChoiceSegmentedButton> createState() =>
      _CollectionVisibilitySingleChoiceSegmentedButtonState();
}

class _CollectionVisibilitySingleChoiceSegmentedButtonState
    extends State<CollectionVisibilitySingleChoiceSegmentedButton> {
  late CollectionVisibility selectedVisibility;

  @override
  void initState() {
    super.initState();
    selectedVisibility = widget.selected;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<CollectionVisibility>(
      segments: CollectionVisibility.values
          .map(
            (visibility) => ButtonSegment(
              value: visibility,
              label: Text(visibility.displayName(context)),
              icon: Icon(
                visibility.icon,
                color: visibility.color,
              ),
            ),
          )
          .toList(),
      selected: {selectedVisibility},
      onSelectionChanged: (newSelection) => setState(() {
        // By default there is only a single segment that can be selected at one time,
        // so its value is always the first entry in the selected set.
        selectedVisibility = newSelection.first;
        widget.visibilityChanged(selectedVisibility);
      }),
    );
  }
}
