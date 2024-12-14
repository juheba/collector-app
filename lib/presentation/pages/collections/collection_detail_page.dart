import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailPageWidget extends StatelessWidget {
  const CollectionDetailPageWidget({
    required this.collectionId,
    super.key,
  });

  final String collectionId;

  static const routeName = 'collectionDetails';
  static const routePath = ':id/items';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CollectionDetailCubit(DatabaseService.instance)..loadCollection(collectionId),
      child: BlocBuilder<CollectionDetailCubit, CollectionDetailState>(
        builder: (context, state) {
          if (state.collection == null) {
            return ScaffoldPage(
              title: '',
              onNavigateBack: () => context.pop(),
              body: const CircularProgressIndicator(),
            );
          } else {
            return ScaffoldPage(
              title: state.collection!.name,
              appBarBackgroundColor: state.collection!.visibility.color,
              appBarForegroundColor: state.collection!.visibility.foregroundColor,
              onNavigateBack: () => context.pop(),
              body: ItemsListWidget(
                items: state.items ?? [],
                isSelectionModeActive: false,
              ),
            );
          }
        },
      ),
    );
  }
}
