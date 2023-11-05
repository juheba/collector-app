import 'package:collector/page/shared/item_editor.dart';
import 'package:flutter/material.dart';

class NewItemPageWidget extends StatelessWidget {
  const NewItemPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ItemEditorForm(),
      ],
    );
  }
}
