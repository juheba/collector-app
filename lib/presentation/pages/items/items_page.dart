import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/items/item_editor_page.dart';
import 'package:collector/presentation/pages/items/state_management/item_list_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_list.dart';
import 'package:collector/presentation/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItemsPageWidget extends StatelessWidget {
  const ItemsPageWidget({super.key});

  static const routeName = 'items';
  static const routePath = '/items';

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return BlocProvider<ItemListCubit>(
      create: (context) => ItemListCubit(DatabaseService.instance)..loadItems(),
      child: BlocBuilder<ItemListCubit, ItemState>(
        builder: (context, state) => ScaffoldPage(
          title: l10n.items_page_title,
          actions: [
            IconButton(
              onPressed: () => context.read<ItemListCubit>().toggleSelectionMode(),
              icon: const Icon(Icons.select_all),
            ),
          ],
          body: switch (state.status) {
            ItemListStatus.initial => const Center(
                child: CircularProgressIndicator(),
              ),
            ItemListStatus.loaded => (state.items.isNotEmpty)
                ? ItemsListWidget(
                    items: state.items,
                    isSelectionModeActive: state.isSelectionModeActive,
                  )
                : EmptyStateWidget(message: l10n.items_page_empty_state),
            ItemListStatus.failure => const Text('Upsi')
          },
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.goNamed(ItemEditorPageWidget.routeNameNew),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
