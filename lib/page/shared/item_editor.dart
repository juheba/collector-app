import 'package:collector/page/shared/item_ownership_status_segmented_button.dart';
import 'package:collector/page/shared/item_status_segmented_button.dart';
import 'package:flutter/material.dart';

class ItemEditorForm extends StatefulWidget {
  const ItemEditorForm({super.key});

  @override
  State<ItemEditorForm> createState() => _ItemEditorFormState();
}

class _ItemEditorFormState extends State<ItemEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter title',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter description',
            ),
          ),
          const Text('Ownership Status:'),
          const OwnershipStatusSingleChoiceSegmentedButton(),
          const Text('Progress Status:'),
          const ItemStatusSingleChoiceSegmentedButton(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IsLendableCheckbox(),
              Text('is lendable?'),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  // Process data.
                }
              },
              child: const Text('Add'),
            ),
          ),
        ],
      ),
    );
  }
}

class IsLendableCheckbox extends StatefulWidget {
  const IsLendableCheckbox({super.key});

  @override
  State<IsLendableCheckbox> createState() => _IsLendableCheckboxState();
}

class _IsLendableCheckboxState extends State<IsLendableCheckbox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

//  final ItemType type;

