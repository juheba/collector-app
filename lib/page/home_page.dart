// '/home' wenn logged in

import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('/home')],
    );
  }
}
