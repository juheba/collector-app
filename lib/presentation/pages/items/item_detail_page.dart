import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/items/item_editor_form.dart';
import 'package:collector/presentation/pages/items/item_editor_page.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/location/location_detail_page.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
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
              ItemDetailStatus.failure => Text(state.errorMessage ?? 'Fehler')
            },
            floatingActionButton: state.status == ItemDetailStatus.loaded
                ? FloatingActionButton(
                    onPressed: () => context.goNamed(
                      ItemEditorPageWidget.routeNameEdit,
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
                  l10n.editor_item_type_title,
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
                if (item.locationId != null)
                  (
                    l10n.location_label,
                    GestureDetector(
                      onTap: () {
                        context.goNamed(LocationDetailPageWidget.routeName, pathParameters: {'id': item.locationId!});
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: _InformationTableRow(
                          icon: Icons.location_on,
                          color: Colors.blueGrey,
                          data: context.read<ItemDetailCubit>().state.location!.name,
                        ),
                      ),
                    ),
                  ),
                (
                  l10n.item_details_can_be_borrowed,
                  _InformationTableRow(
                    icon: item.isLendable ? Icons.check : Icons.close,
                    color: item.isLendable ? Colors.green : Colors.grey,
                    data: item.isLendable ? l10n.yes : l10n.no,
                  ),
                ),
              ],
            ),
            spacingBox,
            Text(
              l10n.editor_item_description,
              overflow: TextOverflow.visible,
            ),
            Text(
              item.description ?? '',
              overflow: TextOverflow.visible,
            ),
            spacingBox,
            if (context.read<ItemDetailCubit>().state.collections != null &&
                context.read<ItemDetailCubit>().state.collections!.isNotEmpty) ...[
              Text(
                l10n.item_details_collections,
                overflow: TextOverflow.visible,
              ),
              Text(
                context.read<ItemDetailCubit>().state.collections!.map((collection) => collection.name).join(', '),
                overflow: TextOverflow.visible,
              ),
              spacingBox,
            ],
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
