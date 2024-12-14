// '/home' wenn logged in

import 'package:collector/generated/l10n.dart';
import 'package:collector/presentation/pages/scaffold_page.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  static const routeName = 'home';
  static const routePath = '/home';

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      title: L10n.of(context).home_page_title,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('/home'),
        ],
      ),
    );
  }
}
