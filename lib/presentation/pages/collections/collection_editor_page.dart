import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/collections/collection_editor_form.dart';
import 'package:collector/presentation/pages/collections/collections_page.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_editor_cubit.dart';
import 'package:collector/presentation/pages/items/item_detail_page.dart';
import 'package:collector/presentation/pages/items/item_editor_form.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_editor_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CollectionEditorPageWidget extends StatelessWidget {
  const CollectionEditorPageWidget({
    this.id,
    super.key,
  });

  final String? id;

  static const routeNameNew = 'collection-editor-new';
  static const routeNameEdit = 'collection-editor-edit';
  static const routePath = '/editor';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionEditorCubit()..initEditorContext(id),
      child: BlocPresentationListener<CollectionEditorCubit, EditorPresentationEvent>(
        listener: (context, event) {
          switch (event) {
            case EditorPresentationEventSaved():
              _handleSavedState(context);
            case EditorPresentationEventSkipSave():
              _handleSkipedState(context);
            case EditorPresentationEventCanceled():
              _handleCancleState(context, isNew: event.isNew, id: event.id);
            case EditorPresentationEventDeleted():
              _handleDeletedState(context);
            case EditorPresentationEventFailure():
              _handleFailureState(context, event.errorMessage);
          }
        },
        child: BlocBuilder<CollectionEditorCubit, CollectionEditorState>(
          builder: (context, state) {
            return ScaffoldPage(
              title: state.status == CollectionEditorStatus.initial
                  ? '...'
                  : state.collection?.name ?? L10n.of(context).new_collection_page_title,
              onNavigateBack: () => context.pop(),
              body: switch (state.status) {
                CollectionEditorStatus.initial => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CollectionEditorStatus.loaded => _Editor(state.editCollection!),
                CollectionEditorStatus.edited => _Editor(state.editCollection!),
              },
            );
          },
        ),
      ),
    );
  }

  void _handleSavedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_collection_saved);
    context.pop();
  }

  void _handleSkipedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_collection_skip_save);
    context.go(CollectionsPageWidget.routePath);
  }

  void _handleCancleState(BuildContext context, {required bool isNew, String? id}) {
    context.pop();
  }

  void _handleDeletedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_collection_deleted);

    context.go(CollectionsPageWidget.routePath);
  }

  void _handleFailureState(BuildContext context, String errorMessage) {
    showSnack(context, errorMessage);
  }

  void showSnack(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _Editor extends StatelessWidget {
  const _Editor(this.collection);

  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CollectionEditorForm(collection: collection),
    );
  }
}
