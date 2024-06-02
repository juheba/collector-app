// '/home' wenn logged in

import 'package:collector/page/scaffold_page.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  static const routeName = 'home';
  static const routePath = '/home';
  static const pageTitle = 'Home';

  @override
  Widget build(BuildContext context) {
    return const ScaffoldPage(
      title: pageTitle,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('/home'),
        ],
      ),
    );
  }
}
