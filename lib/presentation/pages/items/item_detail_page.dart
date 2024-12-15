import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:collector/presentation/utils/utils.dart';
import 'package:collector/presentation/widgets/information_table.dart';
import 'package:collector/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItemDetailPageWidget extends StatelessWidget {
  const ItemDetailPageWidget({
    required this.id,
    super.key,
  });
  final String id;

  static const routeName = 'item-details';
  static const routePath = ':id/details';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailCubit(DatabaseService.instance)..loadItem(id),
      child: BlocBuilder<ItemDetailCubit, ItemDetailState>(
        builder: (context, state) {
          return ScaffoldPage(
            title: state.item?.title ?? '...',
            onNavigateBack: () => context.goNamed(ItemsPageWidget.routeName),
            body: switch (state.status) {
              ItemDetailStatus.initial => const Center(
                  child: CircularProgressIndicator(),
                ),
              ItemDetailStatus.loaded => _Loaded(item: state.item!),
              ItemDetailStatus.newly => _Editor(item: state.item!),
              ItemDetailStatus.edited => _Editor(item: state.item!),
              ItemDetailStatus.failure => Text(state.errorMessage ?? 'Fehler')
            },
            floatingActionButton: state.status == ItemDetailStatus.loaded
                ? FloatingActionButton(
                    onPressed: () => context.read<ItemDetailCubit>().startEditing(state.item),
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
  const _Loaded({required this.item});

  final ItemModel item;

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
                  l10n.editor_item_ownership_status_title,
                  _InformationTableRow(
                    icon: item.ownershipStatus.icon,
                    color: item.ownershipStatus.color,
                    data: item.ownershipStatus.displayName(context),
                  ),
                ),
                (
                  "Item Type",
                  _InformationTableRow(
                    icon: item.type?.icon,
                    color: item.type?.color,
                    data: item.type?.displayName(context) ?? '',
                  ),
                ),
                (
                  l10n.editor_item_progress_title,
                  _InformationTableRow(
                    icon: item.status.icon,
                    color: item.status.color,
                    data: item.status.displayName(context),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              item.isLendable ? l10n.item_details_can_be_borrowed : l10n.item_details_can_not_be_borrowed,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: item.isLendable ? Colors.green : Colors.grey,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              item.description ?? '',
              overflow: TextOverflow.visible,
            ),
            spacingBox,
            if (item.attachment?.attachmentUrl != null)
              Image.network(
                item.attachment!.attachmentUrl!,
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
  const _Editor({required this.item});

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ItemEditorForm(item: item),
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
