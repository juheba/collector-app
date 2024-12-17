import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/collections/state_management/collection_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/Collection_editor.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewCollectionPageWidget extends StatelessWidget {
  const NewCollectionPageWidget({super.key});

  static const routeName = 'new-collection';
  static const routePath = '/new';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: L10n.of(context).new_collection_page_title,
      body: BlocProvider(
        create: (context) => CollectionDetailCubit(DatabaseService.instance)..startEditing(null),
        child: SingleChildScrollView(
          child: CollectionEditorForm(),
        ),
      ),
    );
  }
}
