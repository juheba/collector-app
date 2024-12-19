import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/location/location_editor_page.dart';
import 'package:collector/presentation/pages/location/state_management/location_list_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/location_list.dart';
import 'package:collector/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LocationsPageWidget extends StatelessWidget {
  const LocationsPageWidget({super.key});

  static const routeName = 'locations';
  static const routePath = '/locations';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return BlocProvider<LocationListCubit>(
      create: (context) => LocationListCubit()..loadLocations(),
      child: BlocBuilder<LocationListCubit, LocationState>(
        builder: (context, state) => ScaffoldPage(
          title: l10n.locations_page_title,
          body: switch (state.status) {
            LocationListStatus.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            LocationListStatus.loaded => (state.locations.isNotEmpty)
                ? LocationsListWidget(
                    locations: state.locations,
                    isSelectionModeActive: state.isSelectionModeActive,
                  )
                : EmptyStateWidget(message: l10n.locations_page_empty_state),
            LocationListStatus.failure => const Text('Upsi')
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.goNamed(LocationEditorPageWidget.routeNameNew),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
