// '/' wenn not logged in

import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/collections/collection_editor_page.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_list_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/collection_widget.dart';
import 'package:collector/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CollectionsPageWidget extends StatelessWidget {
  const CollectionsPageWidget({super.key});

  static const routeName = 'collections';
  static const routePath = '/collections';

  @override
  Widget build(BuildContext context) {
    /*return BlocProvider(
      create: (context) => CollectionListCubit(DatabaseService.instance)..loadCollections(),
      child: ScaffoldPage(
        title: L10n.of(context).collections_page_title,
        body: BlocBuilder<CollectionListCubit, CollectionState>(
          builder: (context, state) {
            if (state.collections.isEmpty) {
              return EmptyStateWidget(message: L10n.of(context).collections_page_empty_state);
            } else {
              return CollectionGridWidget(collections: state.collections);
            }
          },
        ),
      ),
    );
  }*/

    final l10n = L10n.of(context);

    return BlocProvider<CollectionListCubit>(
      create: (context) => CollectionListCubit(DatabaseService.instance)..loadCollections(),
      child: BlocBuilder<CollectionListCubit, CollectionState>(
        builder: (context, state) => ScaffoldPage(
          title: l10n.collections_page_title,
          body: switch (state.status) {
            CollectionListStatus.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            CollectionListStatus.loaded => (state.collections.isNotEmpty)
                ? CollectionGridWidget(collections: state.collections)
                : EmptyStateWidget(message: l10n.collections_page_empty_state),
            CollectionListStatus.failure => const Text('Upsi')
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.goNamed(CollectionEditorPageWidget.routeNameNew),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
