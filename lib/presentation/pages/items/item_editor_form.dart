import 'dart:typed_data';

import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/presentation/pages/items/state_management/item_editor_cubit.dart';
import 'package:collector/presentation/pages/shared/is_lendable_checkbox_widget.dart';
import 'package:collector/presentation/pages/shared/item_ownership_status_segmented_button.dart';
import 'package:collector/presentation/pages/shared/item_status_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemEditorForm extends StatefulWidget {
  const ItemEditorForm({required this.item, this.image, super.key});

  final ItemModel item;
  final Uint8List? image;

  @override
  State<ItemEditorForm> createState() => _ItemEditorFormState();
}

class _ItemEditorFormState extends State<ItemEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController titleTextEditingController;
  late TextEditingController descriptionTextEditingController;

  @override
  void initState() {
    super.initState();

    titleTextEditingController = TextEditingController(text: widget.item.title);
    titleTextEditingController.addListener(() {
      context.read<ItemEditorCubit>().updateItem(title: titleTextEditingController.text);
    });

    descriptionTextEditingController = TextEditingController(text: widget.item.description);
    descriptionTextEditingController.addListener(() {
      context.read<ItemEditorCubit>().updateItem(description: descriptionTextEditingController.text);
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    titleTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  void resetForm() {
    if (context.read<ItemEditorCubit>().state.item == null) {
      context.read<ItemEditorCubit>().startEditing();
      titleTextEditingController.clear();
      descriptionTextEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
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
              decoration: InputDecoration(
                labelText: l10n.editor_item_title,
                hintText: l10n.editor_item_title_hint,
                prefixIcon: const Icon(Icons.title),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.editor_item_title_error;
                }
                return null;
              },
            ),
            spacingBox,
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                labelText: l10n.editor_item_description,
                hintText: l10n.editor_item_description_hint,
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            spacingBox,
            _ChooseImage(
              imageData: widget.image,
              imageUrl: widget.item.attachment?.attachmentUrl,
            ),
            spacingBox,
            Text(
              l10n.editor_item_ownership_status_title,
              style: headlineStyle,
            ),
            OwnershipStatusSingleChoiceSegmentedButton(
              selected: context.read<ItemEditorCubit>().state.item?.ownershipStatus ?? ItemOwnershipStatus.wishlist,
              statusChanged: (status) => context.read<ItemEditorCubit>().updateItem(ownershipStatus: status),
            ),
            spacingBox,
            Text(
              l10n.editor_item_progress_title,
              style: headlineStyle,
            ),
            ItemStatusSingleChoiceSegmentedButton(
              selectedStatus: context.read<ItemEditorCubit>().state.item?.status ?? ItemStatus.todo,
              statusChanged: (status) => context.read<ItemEditorCubit>().updateItem(status: status),
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IsLendableCheckbox(
                  isSelected: context.read<ItemEditorCubit>().state.item?.isLendable,
                  onChanged: ({required status}) => context.read<ItemEditorCubit>().updateItem(isLendable: status),
                ),
                Text(
                  l10n.editor_item_can_borrow_title,
                  style: headlineStyle,
                ),
              ],
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!context.read<ItemEditorCubit>().state.isNew) ...[
                  OutlinedButton(
                    style: theme.outlinedButtonTheme.style?.copyWith(
                      foregroundColor: WidgetStatePropertyAll(theme.colorScheme.secondary),
                    ),
                    onPressed: () => context.read<ItemEditorCubit>().deleteItem(),
                    child: Text(l10n.common_action_delete),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<ItemEditorCubit>().cancelEditing(),
                    child: Text(l10n.common_action_cancel),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<ItemEditorCubit>().submitForm();
                      resetForm();
                    }
                  },
                  child: Text(
                    context.read<ItemEditorCubit>().state.isNew ? l10n.common_action_add : l10n.common_action_save,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChooseImage extends StatelessWidget {
  const _ChooseImage({this.imageUrl, this.imageData});

  final String? imageUrl;
  final Uint8List? imageData;

  @override
  Widget build(BuildContext context) {
    final hasNoImage = imageUrl == null && imageData == null;
    final uploadButton = hasNoImage
        ? OutlinedButton(
            onPressed: () => context.read<ItemEditorCubit>().selectImage(),
            child: Text(L10n.of(context).editor_item_upload_image_title),
          )
        : ElevatedButton(
            onPressed: () => context.read<ItemEditorCubit>().selectImage(),
            child: Text(L10n.of(context).editor_item_change_image_title),
          );

    return Container(
      constraints: BoxConstraints.tight(const Size(200, 200)),
      decoration: BoxDecoration(
        border: hasNoImage ? Border.all(color: Colors.grey) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (imageData != null)
              Image.memory(imageData!)
            else if (imageUrl != null)
              Image.network(imageUrl!)
            else
              const Icon(
                Icons.upload_file,
                size: 48,
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: uploadButton,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
