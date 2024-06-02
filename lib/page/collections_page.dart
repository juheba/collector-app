// '/' wenn not logged in

import 'package:collector/model/collection_model.dart';
import 'package:collector/page/scaffold_page.dart';
import 'package:collector/page/shared/collection_widget.dart';
import 'package:flutter/material.dart';

class CollectionsPageWidget extends StatelessWidget {
  const CollectionsPageWidget({super.key});

  static const routeName = 'collections';
  static const routePath = '/collections';
  static const pageTitle = 'Collections';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: pageTitle,
      body: CollectionGridWidget(collections: MockCollections.getCollections()),
    );
  }
}
