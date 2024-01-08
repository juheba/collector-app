import 'package:collector/middleware/cubit/item_detail_cubit.dart';
import 'package:collector/model/item_model.dart';
import 'package:collector/page/shared/checkbox_widget.dart';
import 'package:collector/page/shared/item_ownership_status_segmented_button.dart';
import 'package:collector/page/shared/item_status_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemEditorForm extends StatefulWidget {
  ItemModel? item;

  ItemEditorForm({this.item, super.key});

  @override
  State<ItemEditorForm> createState() => _ItemEditorFormState();
}

class _ItemEditorFormState extends State<ItemEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController titleTextEditingController;
  late TextEditingController descriptionTextEditingController;

  late bool isNew;

  @override
  void initState() {
    super.initState();
    isNew = widget.item == null;

    titleTextEditingController = TextEditingController(text: context.read<ItemDetailCubit>().state.item?.title);
    titleTextEditingController.addListener(() {
      context.read<ItemDetailCubit>().updateItem(title: titleTextEditingController.text);
    });

    descriptionTextEditingController =
        TextEditingController(text: context.read<ItemDetailCubit>().state.item?.description);
    descriptionTextEditingController.addListener(() {
      context.read<ItemDetailCubit>().updateItem(description: descriptionTextEditingController.text);
    });
  }

  void showSnack(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Item saved.'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  void resetForm() {
    if (isNew) {
      widget.item = null;
      context.read<ItemDetailCubit>().startEditing(widget.item);
      titleTextEditingController.clear();
      descriptionTextEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: titleTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter title',
                prefixIcon: Icon(Icons.title),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Ownership Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            OwnershipStatusSingleChoiceSegmentedButton(
              selected: context.read<ItemDetailCubit>().state.item?.ownershipStatus,
              statusChanged: (status) => context.read<ItemDetailCubit>().updateItem(ownershipStatus: status),
            ),
            const SizedBox(height: 10),
            const Text(
              'Progress Status:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ItemStatusSingleChoiceSegmentedButton(
              selectedStatus: context.read<ItemDetailCubit>().state.item?.status,
              statusChanged: (status) => context.read<ItemDetailCubit>().updateItem(status: status),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IsLendableCheckbox(
                  isSelected: context.read<ItemDetailCubit>().state.item?.isLendable,
                  onChanged: (isLendable) => context.read<ItemDetailCubit>().updateItem(isLendable: isLendable),
                ),
                const Text(
                  'is lendable?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<ItemDetailCubit>().submitForm();
                  showSnack(context);
                  resetForm();
                }
              },
              child: isNew ? const Text('Add') : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

//  final ItemType type;

