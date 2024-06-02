import 'package:collector/model/collection_model.dart';
import 'package:collector/page/scaffold_page.dart';
import 'package:collector/page/shared/item_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailPageWidget extends StatelessWidget {
  const CollectionDetailPageWidget({
    required this.collection,
    super.key,
  });
  final CollectionModel collection;

  static const routeName = 'collectionDetails';
  static const routePath = ':id/items';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: collection.name,
      appBarBackgroundColor: collection.visibility.color,
      appBarForegroundColor: collection.visibility.foregroundColor,
      onNavigateBack: () => context.pop(),
      body: const ItemsListWidget(
        items: [],
        isSelectionModeActive: false,
      ),
    );
  }
}
