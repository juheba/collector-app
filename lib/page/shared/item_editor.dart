import 'package:collector/middleware/cubit/item/item_detail_cubit.dart';
import 'package:collector/middleware/cubit/item/item_list_cubit.dart';
import 'package:collector/model/item_model.dart';
import 'package:collector/page/shared/checkbox_widget.dart';
import 'package:collector/page/shared/item_ownership_status_segmented_button.dart';
import 'package:collector/page/shared/item_status_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemEditorForm extends StatefulWidget {
  ItemEditorForm({this.item, super.key});
  ItemModel? item;

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
    final theme = Theme.of(context);
    final headlineStyle = theme.textTheme.labelLarge;

    const spacingBox = SizedBox(height: 20);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
            spacingBox,
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Enter description',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            spacingBox,
            OutlinedButton(
              onPressed: () => context.read<ItemDetailCubit>().selectImage(),
              child: const Text('upload Image'),
            ),
            if (context.read<ItemDetailCubit>().state.image != null)
              Image.memory(
                context.read<ItemDetailCubit>().state.image!,
                height: 200,
                width: 200,
              )
            else if (context.read<ItemDetailCubit>().state.item?.attachment?.attachmentUrl != null)
              Image.network(
                context.read<ItemDetailCubit>().state.item!.attachment!.attachmentUrl!,
                height: 200,
                width: 200,
              ),
            spacingBox,
            Text(
              'Ownership Status:',
              style: headlineStyle,
            ),
            OwnershipStatusSingleChoiceSegmentedButton(
              selected: context.read<ItemDetailCubit>().state.item?.ownershipStatus,
              statusChanged: (status) => context.read<ItemDetailCubit>().updateItem(ownershipStatus: status),
            ),
            spacingBox,
            Text(
              'Progress Status:',
              style: headlineStyle,
            ),
            ItemStatusSingleChoiceSegmentedButton(
              selectedStatus: context.read<ItemDetailCubit>().state.item?.status,
              statusChanged: (status) => context.read<ItemDetailCubit>().updateItem(status: status),
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IsLendableCheckbox(
                  isSelected: context.read<ItemDetailCubit>().state.item?.isLendable,
                  onChanged: (isLendable) => context.read<ItemDetailCubit>().updateItem(isLendable: isLendable),
                ),
                Text(
                  'is lendable?',
                  style: headlineStyle,
                ),
              ],
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!isNew) ...[
                  OutlinedButton(
                    style: theme.outlinedButtonTheme.style?.copyWith(
                      foregroundColor: WidgetStatePropertyAll(theme.colorScheme.secondary),
                    ),
                    onPressed: () => context.read<ItemListCubit>().deleteItem(widget.item?.id ?? ''),
                    child: const Text('Delete'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<ItemDetailCubit>().cancelEditing(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
                FilledButton(
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
          ],
        ),
      ),
    );
  }
}
