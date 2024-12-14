import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/models/item_model.dart';
import 'package:collector/presentation/pages/items/items_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:collector/presentation/utils/utils.dart';
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
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(
                      item.type?.icon,
                      size: 50,
                      color: item.type?.color,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.item_details_ownership_status(item.ownershipStatus.name)),
                        Text(l10n.item_details_process(item.status.name)),
                        if (item.isLendable)
                          Text(
                            l10n.item_details_can_be_borrowed,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.green,
                                ),
                          )
                        else
                          Text(
                            l10n.item_details_can_not_be_borrowed,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: Colors.grey,
                                ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: margin,
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
