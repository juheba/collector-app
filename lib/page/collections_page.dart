// '/' wenn not logged in

import 'package:collector/model/collection_model.dart';
import 'package:collector/page/shared/collection_widget.dart';
import 'package:flutter/material.dart';

class CollectionsPageWidget extends StatelessWidget {
  const CollectionsPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CollectionGridWidget(collections: MockCollections.getCollections()),
      ],
    );
  }
}
