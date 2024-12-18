import 'dart:typed_data';

import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/models/item_ownership_status.dart';
import 'package:collector/models/item_status.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/location/state_management/location_detail_cubit.dart';
import 'package:collector/presentation/pages/shared/is_lendable_checkbox_widget.dart';
import 'package:collector/presentation/pages/shared/item_ownership_status_segmented_button.dart';
import 'package:collector/presentation/pages/shared/item_status_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationEditorForm extends StatefulWidget {
  LocationEditorForm({this.location, super.key});
  LocationModel? location;

  @override
  State<LocationEditorForm> createState() => _LocationEditorFormState();
}

class _LocationEditorFormState extends State<LocationEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameTextEditingController;
  late TextEditingController descriptionTextEditingController;

  late bool isNew;

  @override
  void initState() {
    super.initState();
    isNew = widget.location == null;

    nameTextEditingController = TextEditingController(text: context.read<LocationDetailCubit>().state.location?.name);
    nameTextEditingController.addListener(() {
      context.read<LocationDetailCubit>().updateLocation(name: nameTextEditingController.text);
    });

    descriptionTextEditingController =
        TextEditingController(text: context.read<LocationDetailCubit>().state.location?.description);
    descriptionTextEditingController.addListener(() {
      context.read<LocationDetailCubit>().updateLocation(description: descriptionTextEditingController.text);
    });
  }

  void showSnack(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  void resetForm() {
    if (isNew) {
      widget.location = null;
      context.read<LocationDetailCubit>().startEditing(widget.location);
      nameTextEditingController.clear();
      descriptionTextEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final theme = Theme.of(context);

    const spacingBox = SizedBox(height: 20);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nameTextEditingController,
              decoration: InputDecoration(
                labelText: l10n.editor_location_name,
                hintText: l10n.editor_location_name_hint,
                prefixIcon: const Icon(Icons.title),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.editor_location_name_error;
                }
                return null;
              },
            ),
            spacingBox,
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                labelText: l10n.editor_location_description,
                hintText: l10n.editor_location_description_hint,
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            spacingBox,
            _ChooseImage(
              imageData: context.read<LocationDetailCubit>().state.image,
              imageUrl: context.read<LocationDetailCubit>().state.location?.attachment?.attachmentUrl,
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
                    onPressed: () async {
                      if (await context.read<LocationDetailCubit>().delete()) {
                        showSnack(context, L10n.of(context).notification_location_deleted);
                      }
                    },
                    child: Text(l10n.common_action_delete),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<LocationDetailCubit>().cancelEditing(),
                    child: Text(l10n.common_action_cancel),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LocationDetailCubit>().submitForm();
                      showSnack(context, L10n.of(context).notification_location_saved);
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
            onPressed: () => context.read<LocationDetailCubit>().selectImage(),
            child: Text(L10n.of(context).editor_location_upload_image_label),
          )
        : ElevatedButton(
            onPressed: () => context.read<LocationDetailCubit>().selectImage(),
            child: Text(L10n.of(context).editor_location_change_image_label),
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
            ),
          ],
        ),
      ),
    );
  }
}
