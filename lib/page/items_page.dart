import 'package:collector/data/database_service.dart';
import 'package:collector/middleware/cubit/item_list_cubit.dart';
import 'package:collector/page/shared/items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsPageWidget extends StatelessWidget {
  const ItemsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemListCubit>(
      create: (context) => ItemListCubit(DatabaseService.instance)..loadItems(),
      child: const Column(
        children: [
          ItemsListWidget(),
        ],
      ),
    );
  }
}
