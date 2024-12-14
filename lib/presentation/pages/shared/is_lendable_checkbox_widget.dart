import 'package:collector/model/item_model.dart';
import 'package:flutter/material.dart';

class IsLendableCheckbox extends StatefulWidget {
  const IsLendableCheckbox({
    required this.onChanged,
    this.isSelected,
    super.key,
  });

  /// Whether the checkbox is checked
  final bool? isSelected;

  /// Function to be called when the checkbox is toggled
  final void Function({required bool status}) onChanged;

  @override
  State<IsLendableCheckbox> createState() => _IsLendableCheckboxState();
}

class _IsLendableCheckboxState extends State<IsLendableCheckbox> {
  bool isChecked = defaultIsLendable;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isSelected ?? defaultIsLendable;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          widget.onChanged(status: isChecked);
        });
      },
    );
  }
}
