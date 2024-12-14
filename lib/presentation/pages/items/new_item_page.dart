import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewItemPageWidget extends StatelessWidget {
  const NewItemPageWidget({super.key});

  static const routeName = 'newItem';
  static const routePath = '/items/new';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: L10n.of(context).new_item_page_title,
      body: BlocProvider(
        create: (context) => ItemDetailCubit(DatabaseService.instance)..startEditing(null),
        child: SingleChildScrollView(
          child: ItemEditorForm(),
        ),
      ),
    );
  }
}
