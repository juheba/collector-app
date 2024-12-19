import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/collection_model.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/collections/collections_page.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/collection_editor.dart';
import 'package:collector/presentation/pages/shared/item_list.dart';
import 'package:collector/presentation/utils/collection_visibility_utils.dart';
import 'package:collector/presentation/widgets/empty_state_widget.dart';
import 'package:collector/presentation/widgets/information_table.dart';
import 'package:collector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CollectionDetailPageWidget extends StatelessWidget {
  const CollectionDetailPageWidget({
    required this.collectionId,
    super.key,
  });

  final String collectionId;

  static const routeName = 'collection-details';
  static const routePath = ':id/details';

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
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return ScaffoldPage(
              title: state.collection?.name ?? '...',
              onNavigateBack: () => context.pop(),
              body: switch (state.status) {
                CollectionDetailStatus.initial => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CollectionDetailStatus.loaded => _Loaded(collection: state.collection!, items: state.items),
                CollectionDetailStatus.newly => throw UnimplementedError(),
                CollectionDetailStatus.edited => _Editor(collection: state.collection!),
                CollectionDetailStatus.deleted => _handleDeletedState(context),
                CollectionDetailStatus.failure => Text(state.errorMessage ?? 'Fehler')
              },
              floatingActionButton: state.status == CollectionDetailStatus.loaded
                  ? FloatingActionButton(
                      onPressed: () => context.read<CollectionDetailCubit>().startEditing(state.collection),
                      child: const Icon(Icons.edit),
                    )
                  : null,
            );
          }
        },
      ),
    );
  }
}

Widget _handleDeletedState(BuildContext context) {
  Future.microtask(() => context.go(CollectionsPageWidget.routePath));
  return const SizedBox.shrink(); // Empty widget while navigating
}

class _Loaded extends StatelessWidget {
  const _Loaded({required this.collection, this.items});

  final CollectionModel collection;
  final List<ItemModel>? items;

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
            InformationTable(
              rows: [
                (
                  l10n.editor_collection_visibility_label,
                  _InformationTableRow(
                    icon: collection.visibility.icon,
                    color: collection.visibility.color,
                    data: collection.visibility.displayName(context),
                  ),
                ),
              ],
            ),
            spacingBox,
            Text(
              collection.description ?? '',
              overflow: TextOverflow.visible,
            ),
            spacingBox,
            if (items != null && items!.isNotEmpty)
              ItemsListWidget(
                items: items!,
                isSelectionModeActive: false,
              )
            else
              EmptyStateWidget(message: l10n.items_page_empty_state),
          ],
        ),
      ),
    );
  }
}

class _Editor extends StatelessWidget {
  const _Editor({required this.collection});

  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CollectionEditorForm(collection: collection),
    );
  }
}

class _InformationTableRow extends StatelessWidget {
  const _InformationTableRow({
    required this.data,
    this.icon,
    this.color,
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
