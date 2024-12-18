import 'package:collector/data/persistence/database_service.dart';
import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/items/state_management/item_detail_cubit.dart';
import 'package:collector/presentation/pages/location/state_management/location_detail_cubit.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:collector/presentation/pages/shared/item_editor.dart';
import 'package:collector/presentation/pages/shared/location_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewLocationPageWidget extends StatelessWidget {
  const NewLocationPageWidget({super.key});

  static const routeName = 'new-location';
  static const routePath = '/new';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: L10n.of(context).new_location_page_title,
      body: BlocProvider(
        create: (context) => LocationDetailCubit(DatabaseService.instance)..startEditing(null),
        child: SingleChildScrollView(
          child: LocationEditorForm(),
        ),
      ),
    );
  }
}
