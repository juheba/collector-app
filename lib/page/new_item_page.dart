import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/middleware/cubit/item/item_detail_cubit.dart';
import 'package:collector/page/scaffold_page.dart';

import 'package:collector/page/shared/item_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewItemPageWidget extends StatelessWidget {
  const NewItemPageWidget({super.key});

  static const routeName = 'newItem';
  static const routePath = '/items/new';
  static const pageTitle = 'New item';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: pageTitle,
      body: BlocProvider(
        create: (context) => ItemDetailCubit(DatabaseService.instance)..startEditing(null),
        child: SingleChildScrollView(
          child: ItemEditorForm(),
        ),
      ),
    );
  }
}
