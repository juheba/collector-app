import 'dart:typed_data';

import 'package:collector/generated/l10n.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/location/state_management/location_editor_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationEditorForm extends StatefulWidget {
  const LocationEditorForm({required this.location, this.image, super.key});

  final LocationModel location;
  final Uint8List? image;

  @override
  State<LocationEditorForm> createState() => _LocationEditorFormState();
}

class _LocationEditorFormState extends State<LocationEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameTextEditingController;
  late TextEditingController descriptionTextEditingController;

  @override
  void initState() {
    super.initState();

    nameTextEditingController = TextEditingController(text: widget.location.name);
    nameTextEditingController.addListener(() {
      context.read<LocationEditorCubit>().updateChange(name: nameTextEditingController.text);
    });

    descriptionTextEditingController = TextEditingController(text: widget.location.description);
    descriptionTextEditingController.addListener(() {
      context.read<LocationEditorCubit>().updateChange(description: descriptionTextEditingController.text);
    });
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    nameTextEditingController.dispose();
    descriptionTextEditingController.dispose();
    super.dispose();
  }

  void resetForm() {
    if (context.read<LocationEditorCubit>().state.location == null) {
      context.read<LocationEditorCubit>().startEditing();
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
              imageData: widget.image,
              imageUrl: widget.location.attachment?.attachmentUrl,
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!context.read<LocationEditorCubit>().state.isNew) ...[
                  OutlinedButton(
                    style: theme.outlinedButtonTheme.style?.copyWith(
                      foregroundColor: WidgetStatePropertyAll(theme.colorScheme.secondary),
                    ),
                    onPressed: () => context.read<LocationEditorCubit>().deleteLocation(),
                    child: Text(l10n.common_action_delete),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<LocationEditorCubit>().cancelEditing(),
                    child: Text(l10n.common_action_cancel),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<LocationEditorCubit>().submitForm();
                      resetForm();
                    }
                  },
                  child: Text(
                    context.read<LocationEditorCubit>().state.isNew ? l10n.common_action_add : l10n.common_action_save,
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
            onPressed: () => context.read<LocationEditorCubit>().selectImage(),
            child: Text(L10n.of(context).editor_location_upload_image_label),
          )
        : ElevatedButton(
            onPressed: () => context.read<LocationEditorCubit>().selectImage(),
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
