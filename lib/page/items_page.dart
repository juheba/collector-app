import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/middleware/cubit/item/item_list_cubit.dart';
import 'package:collector/page/scaffold_page.dart';
import 'package:collector/page/shared/empty_state_widget.dart';
import 'package:collector/page/shared/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsPageWidget extends StatelessWidget {
  const ItemsPageWidget({super.key});

  static const routeName = 'items';
  static const routePath = '/items';
  static const pageTitle = 'Items';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemListCubit>(
      create: (context) => ItemListCubit(DatabaseService.instance)..loadItems(),
      child: BlocBuilder<ItemListCubit, ItemState>(
        builder: (context, state) => ScaffoldPage(
          title: pageTitle,
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
                : const EmptyStateWidget(message: 'Keine Items vorhanden'),
            ItemListStatus.failure => const Text('Upsi')
          },
        ),
      ),
    );
  }
}
