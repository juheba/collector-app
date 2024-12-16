// '/' wenn not logged in

import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/collections/new_collection_page.dart';
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
    return BlocProvider(
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.goNamed(NewCollectionPageWidget.routeName),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
