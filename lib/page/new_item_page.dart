import 'package:collector/data/database_service.dart';
import 'package:collector/middleware/cubit/item/item_detail_cubit.dart';

import 'package:collector/page/shared/item_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewItemPageWidget extends StatelessWidget {
  const NewItemPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemDetailCubit(DatabaseService.instance)..startEditing(null),
      child: ItemEditorForm(),
    );
  }
}
