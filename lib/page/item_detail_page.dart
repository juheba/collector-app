import 'package:collector/data/database_service.dart';
import 'package:collector/middleware/cubit/item_detail_cubit.dart';
import 'package:collector/page/shared/item_editor.dart';
import 'package:collector/page/shared/items_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDetailPageWidget extends StatelessWidget {
  final String id;

  const ItemDetailPageWidget({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailCubit(DatabaseService.instance)..loadItem(id),
      child: BlocBuilder<ItemDetailCubit, ItemDetailState>(
        builder: (context, state) {
          switch (state.status) {
            case ItemDetailStatus.initial:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ItemDetailStatus.loaded:
              return Column(
                children: [
                  ItemListElementWidget(item: state.item!),
                  ItemEditorForm(item: state.item!),
                ],
              );

            case ItemDetailStatus.newly:
              return Column(
                children: [
                  ItemListElementWidget(item: state.item!),
                  ItemEditorForm(item: state.item!),
                ],
              );

            case ItemDetailStatus.edited:
              return Column(
                children: [
                  ItemListElementWidget(item: state.item!),
                  ItemEditorForm(item: state.item!),
                ],
              );

            case ItemDetailStatus.failure:
              return Text(state.errorMessage ?? 'Fehler');
          }
        },
      ),
    );
  }
}
