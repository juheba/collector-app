import 'dart:typed_data';

import 'package:collector/generated/l10n.dart';
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
    final snackBar = SnackBar(
      content: Text(L10n.of(context).notification_item_saved),
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
              imageData: context.read<ItemDetailCubit>().state.image,
              imageUrl: context.read<ItemDetailCubit>().state.item?.attachment?.attachmentUrl,
            ),
            spacingBox,
            Text(
              l10n.editor_item_ownership_status_title,
              style: headlineStyle,
            ),
            OwnershipStatusSingleChoiceSegmentedButton(
              selected: context.read<ItemDetailCubit>().state.item?.ownershipStatus,
              statusChanged: (status) => context.read<ItemDetailCubit>().updateItem(ownershipStatus: status),
            ),
            spacingBox,
            Text(
              l10n.editor_item_progress_title,
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
                  l10n.editor_item_can_borrow_title,
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
                    onPressed: () => context.read<ItemDetailCubit>().delete(),
                    child: Text(l10n.common_action_delete),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<ItemDetailCubit>().cancelEditing(),
                    child: Text(l10n.common_action_cancel),
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
                  child: Text(isNew ? l10n.common_action_add : l10n.common_action_save),
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
            onPressed: () => context.read<ItemDetailCubit>().selectImage(),
            child: Text(L10n.of(context).editor_item_upload_image_title),
          )
        : ElevatedButton(
            onPressed: () => context.read<ItemDetailCubit>().selectImage(),
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
              const Expanded(
                child: Icon(
                  Icons.upload_file,
                  size: 48,
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: uploadButton,
              ),
            )
          ],
        ),
      ),
    );
  }
}
