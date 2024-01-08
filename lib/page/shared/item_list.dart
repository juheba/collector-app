import 'package:collector/middleware/cubit/item_list_cubit.dart';
import 'package:collector/page/shared/item_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ItemsListWidget extends StatelessWidget {
  const ItemsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemListCubit, ItemState>(
      builder: (context, state) {
        switch (state.status) {
          case ItemListStatus.initial:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ItemListStatus.loaded:
            return Expanded(
              child: ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      GoRouter.of(context).goNamed(
                        'item-details',
                        pathParameters: {'id': state.items[index].id},
                      );
                    },
                    child: ItemListElementWidget(item: state.items[index]),
                  );
                },
              ),
            );

          case ItemListStatus.failure:
            return const Text('Upsi');
        }
      },
    );
  }
}
