import 'package:collector/generated/l10n.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_detail_cubit.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_editor_cubit.dart';
import 'package:collector/presentation/pages/shared/collection_visibility_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionEditorForm extends StatefulWidget {
  const CollectionEditorForm({required this.collection, super.key});

  final CollectionModel collection;

  @override
  State<CollectionEditorForm> createState() => _CollectionEditorFormState();
}

class _CollectionEditorFormState extends State<CollectionEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameTextEditingController;
  late TextEditingController descriptionTextEditingController;

  @override
  void initState() {
    super.initState();

    nameTextEditingController = TextEditingController(text: widget.collection.name);
    nameTextEditingController.addListener(() {
      context.read<CollectionEditorCubit>().updateCollection(name: nameTextEditingController.text);
    });

    descriptionTextEditingController = TextEditingController(text: widget.collection.description);
    descriptionTextEditingController.addListener(() {
      context.read<CollectionEditorCubit>().updateCollection(description: descriptionTextEditingController.text);
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
    if (context.read<CollectionEditorCubit>().state.isNew) {
      context.read<CollectionEditorCubit>().startEditing();
      nameTextEditingController.clear();
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
              controller: nameTextEditingController,
              decoration: InputDecoration(
                labelText: l10n.editor_collection_name,
                hintText: l10n.editor_collection_name_hint,
                prefixIcon: const Icon(Icons.title),
                border: const OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.editor_collection_name_error;
                }
                return null;
              },
            ),
            spacingBox,
            TextFormField(
              controller: descriptionTextEditingController,
              decoration: InputDecoration(
                labelText: l10n.editor_collection_description,
                hintText: l10n.editor_collection_description_hint,
                prefixIcon: const Icon(Icons.description),
                border: const OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
            spacingBox,
            Text(
              l10n.editor_collection_visibility_label,
              style: headlineStyle,
            ),
            CollectionVisibilitySingleChoiceSegmentedButton(
              selected: context.read<CollectionEditorCubit>().state.collection?.visibility ?? defaultVisibility,
              visibilityChanged: (visibility) =>
                  context.read<CollectionEditorCubit>().updateCollection(visibility: visibility),
            ),
            spacingBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!context.read<CollectionEditorCubit>().state.isNew) ...[
                  OutlinedButton(
                    style: theme.outlinedButtonTheme.style?.copyWith(
                      foregroundColor: WidgetStatePropertyAll(theme.colorScheme.secondary),
                    ),
                    onPressed: () => context.read<CollectionEditorCubit>().deleteCollection(),
                    child: Text(l10n.common_action_delete),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  OutlinedButton(
                    onPressed: () => context.read<CollectionEditorCubit>().cancelEditing(),
                    child: Text(l10n.common_action_cancel),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                ],
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<CollectionEditorCubit>().submitForm();
                      resetForm();
                    }
                  },
                  child: Text(
                    context.read<CollectionEditorCubit>().state.isNew
                        ? l10n.common_action_add
                        : l10n.common_action_save,
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
