import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/models/location_model.dart';
import 'package:collector/presentation/pages/location/location_editor_page.dart';
import 'package:collector/presentation/pages/location/locations_page.dart';
import 'package:collector/presentation/pages/location/state_management/location_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
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
              LocationDetailStatus.failure => Text(state.errorMessage ?? 'Fehler')
            },
            floatingActionButton: state.status == LocationDetailStatus.loaded
                ? FloatingActionButton(
                    onPressed: () => context.goNamed(
                      LocationEditorPageWidget.routeNameEdit,
                      pathParameters: {'id': id},
                    ),
                    child: const Icon(Icons.edit),
                  )
                : null,
          );
        },
      ),
    );
  }
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.location});

  final LocationModel location;

  @override
  Widget build(BuildContext context) {
    const spacingBox = SizedBox(height: 20);

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
