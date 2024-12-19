import 'dart:typed_data';

import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/location/location_detail_page.dart';
import 'package:collector/presentation/pages/location/location_editor_form.dart';
import 'package:collector/presentation/pages/location/locations_page.dart';
import 'package:collector/presentation/pages/location/state_management/location_editor_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/editor_presentation_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationEditorPageWidget extends StatelessWidget {
  const LocationEditorPageWidget({
    this.id,
    super.key,
  });

  final String? id;

  static const routeNameNew = 'location-editor-new';
  static const routeNameEdit = 'location-editor-edit';
  static const routePath = '/editor';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationEditorCubit()..initEditorContext(id),
      child: BlocPresentationListener<LocationEditorCubit, EditorPresentationEvent>(
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
        child: BlocBuilder<LocationEditorCubit, LocationEditorState>(
          builder: (context, state) {
            return ScaffoldPage(
              title: state.status == LocationEditorStatus.initial
                  ? '...'
                  : state.location?.name ?? L10n.of(context).new_location_page_title,
              onNavigateBack: () => context.goNamed(LocationsPageWidget.routeName),
              body: switch (state.status) {
                LocationEditorStatus.initial => const Center(
                    child: CircularProgressIndicator(),
                  ),
                LocationEditorStatus.loaded => _Editor(state.editLocation!, state.image),
                LocationEditorStatus.edited => _Editor(state.editLocation!, state.image),
              },
            );
          },
        ),
      ),
    );
  }

  void _handleSavedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_location_saved);
    context.go(LocationsPageWidget.routePath);
  }

  void _handleSkipedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_location_skip_save);
    context.go(LocationsPageWidget.routePath);
  }

  void _handleCancleState(BuildContext context, {required bool isNew, String? id}) {
    if (isNew) {
      context.goNamed(
        LocationsPageWidget.routeName,
      );
    } else {
      context.goNamed(
        LocationDetailPageWidget.routeName,
        pathParameters: {'id': id ?? ''},
      );
    }
  }

  void _handleDeletedState(BuildContext context) {
    showSnack(context, L10n.of(context).notification_location_deleted);

    context.go(LocationsPageWidget.routePath);
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
  const _Editor(this.location, this.image);

  final LocationModel location;
  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LocationEditorForm(location: location, image: image),
    );
  }
}
