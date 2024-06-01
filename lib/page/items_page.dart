import 'package:collector/data/database_service.dart';
import 'package:collector/middleware/cubit/item_list_cubit.dart';
import 'package:collector/page/shared/item_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsPageWidget extends StatelessWidget {
  const ItemsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemListCubit>(
      create: (context) => ItemListCubit(DatabaseService.instance)..loadItems(),
      child: BlocBuilder<ItemListCubit, ItemState>(
        builder: (context, state) {
          switch (state.status) {
            case ItemListStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ItemListStatus.loaded:
              return Column(
                children: [
                  AppBar(
                    actions: [
                      IconButton(
                        onPressed: () => context.read<ItemListCubit>().toggleSelectionMode(),
                        icon: const Icon(Icons.select_all),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ItemsListWidget(
                      items: state.items,
                      isSelectionModeActive: state.isSelectionModeActive,
                    ),
                  ),
                ],
              );

            case ItemListStatus.failure:
              return const Text('Upsi');
          }
        },
      ),
    );
  }
}
