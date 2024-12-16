import 'package:collector/generated/l10n.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/collection_visibility.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_editor_cubit.dart';
import 'package:collector/presentation/pages/shared/collection_visibility_segmented_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionEditorForm extends StatefulWidget {
  CollectionEditorForm({this.collection, super.key});
  CollectionModel? collection;

  @override
  State<CollectionEditorForm> createState() => _CollectionEditorFormState();
}

class _CollectionEditorFormState extends State<CollectionEditorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController nameTextEditingController;
  late TextEditingController descriptionTextEditingController;

  late bool isNew;

  @override
  void initState() {
    super.initState();
    isNew = widget.collection == null;

    nameTextEditingController =
        TextEditingController(text: context.read<CollectionEditorCubit>().state.collection?.name);
    nameTextEditingController.addListener(() {
      context.read<CollectionEditorCubit>().updateCollection(name: nameTextEditingController.text);
    });

    descriptionTextEditingController =
        TextEditingController(text: context.read<CollectionEditorCubit>().state.collection?.description);
    descriptionTextEditingController.addListener(() {
      context.read<CollectionEditorCubit>().updateCollection(description: descriptionTextEditingController.text);
    });
  }

  void showSnack(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(L10n.of(context).notification_collection_saved),
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
      widget.collection = null;
      context.read<CollectionEditorCubit>().startEditing(widget.collection);
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
              selected:
                  context.read<CollectionEditorCubit>().state.collection?.visibility ?? CollectionVisibility.private,
              visibilityChanged: (visibility) =>
                  context.read<CollectionEditorCubit>().updateCollection(visibility: visibility),
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
                    onPressed: () => context.read<CollectionEditorCubit>().delete(),
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
