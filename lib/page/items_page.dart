import 'package:collector/model/item_model.dart';
import 'package:collector/page/shared/items_widget.dart';
import 'package:collector/page/shared/user_profile_widget.dart';
import 'package:flutter/material.dart';

class ItemsPageWidget extends StatelessWidget {
  const ItemsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MockUserWidget(),
        ItemsListWidget(
          items: MockItems.getItems(),
        ),
      ],
    );
  }
}
