import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/items/item_detail_page.dart';
import 'package:collector/presentation/pages/items/item_editor_form.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_editor_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItemEditorPageWidget extends StatelessWidget {
  const ItemEditorPageWidget({
    this.id,
    super.key,
  });

  final String? id;

  static const routeNameNew = 'item-editor-new';
  static const routeNameEdit = 'item-editor-edit';
  static const routePath = '/editor';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemEditorCubit()..initEditorContext(id),
      child: BlocPresentationListener<ItemEditorCubit, EditorPresentationEvent>(
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
        child: BlocBuilder<ItemEditorCubit, ItemEditorState>(
          builder: (context, state) {
            return ScaffoldPage(
              title: state.status == ItemEditorStatus.initial
                  ? '...'
                  : state.item?.title ?? L10n.of(context).new_item_page_title,
              onNavigateBack: () => context.goNamed(ItemsPageWidget.routeName),
              body: switch (state.status) {
                ItemEditorStatus.initial => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ItemEditorStatus.loaded => _Editor(state.editItem!, state.image),
                ItemEditorStatus.edited => _Editor(state.editItem!, state.image),
              },
            );
          },
        ),
      ),
    );
  }

  void _handleSavedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_item_saved);
    context.pop();
  }

  void _handleSkipedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_item_skip_save);
    context.go(ItemsPageWidget.routePath);
  }

  void _handleCancleState(BuildContext context, {required bool isNew, String? id}) {
    context.pop();
  }

  void _handleDeletedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_item_deleted);

    context.go(ItemsPageWidget.routePath);
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
  const _Editor(this.item, this.image);

  final ItemModel item;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ItemEditorForm(item: item, image: image),
    );
  }
}
