// '/' wenn not logged in

import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/middleware/cubit/collection/collection_list_cubit.dart';
import 'package:collector/page/scaffold_page.dart';
import 'package:collector/page/shared/collection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionsPageWidget extends StatelessWidget {
  const CollectionsPageWidget({super.key});

  static const routeName = 'collections';
  static const routePath = '/collections';
  static const pageTitle = 'Collections';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionListCubit(DatabaseService.instance)..loadCollections(),
      child: ScaffoldPage(
        title: pageTitle,
        body: BlocBuilder<CollectionListCubit, CollectionState>(
          builder: (context, state) {
            return CollectionGridWidget(collections: state.collections);
          },
        ),
      ),
    );
  }
}
