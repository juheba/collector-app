import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/location/locations_page.dart';
import 'package:collector/presentation/pages/location/state_management/location_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:collector/presentation/pages/shared/location_editor.dart';
import 'package:collector/presentation/utils/utils.dart';
import 'package:collector/presentation/widgets/information_table.dart';
import 'package:collector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationDetailPageWidget extends StatelessWidget {
  const LocationDetailPageWidget({
    required this.id,
    super.key,
  });
  final String id;

  static const routeName = 'location-details';
  static const routePath = ':id/details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationDetailCubit(DatabaseService.instance)..loadLocation(id),
      child: BlocBuilder<LocationDetailCubit, LocationDetailState>(
        builder: (context, state) {
          return ScaffoldPage(
            title: state.location?.name ?? '...',
            onNavigateBack: () => context.goNamed(LocationsPageWidget.routeName),
            body: switch (state.status) {
              LocationDetailStatus.initial => const Center(
                  child: CircularProgressIndicator(),
                ),
              LocationDetailStatus.loaded => _Loaded(location: state.location!),
              LocationDetailStatus.newly => _Editor(location: state.location!),
              LocationDetailStatus.edited => _Editor(location: state.location!),
              LocationDetailStatus.deleted => _handleDeletedState(context),
              LocationDetailStatus.failure => Text(state.errorMessage ?? 'Fehler')
            },
            floatingActionButton: state.status == LocationDetailStatus.loaded
                ? FloatingActionButton(
                    onPressed: () => context.read<LocationDetailCubit>().startEditing(state.location),
                    child: const Icon(Icons.edit),
                  )
                : null,
          );
        },
      ),
    );
  }
}

Widget _handleDeletedState(BuildContext context) {
  Future.microtask(() => context.go(LocationsPageWidget.routePath));
  return const SizedBox.shrink(); // Empty widget while navigating
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    const spacingBox = SizedBox(height: 20);
    final l10n = L10n.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: margin,
          vertical: margin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              location.description ?? '',
              overflow: TextOverflow.visible,
            ),
            spacingBox,
            if (location.attachment?.attachmentUrl != null)
              Image.network(
                location.attachment!.attachmentUrl!,
                height: 200,
                width: 200,
              ),
          ],
        ),
      ),
    );
  }
}

class _Editor extends StatelessWidget {
  const _Editor({required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LocationEditorForm(location: location),
    );
  }
}

class _InformationTableRow extends StatelessWidget {
  const _InformationTableRow({
    this.icon,
    this.color,
    required this.data,
  });

  final IconData? icon;
  final Color? color;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: color),
        const SizedBox(width: 8),
        Text(data),
      ],
    );
  }
}
