// '/' wenn logged in

import 'package:collector/page/shared/user_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class HomePageWidget extends StatelessWidget {
  final UserProfile user;
  final String idToken;

  const HomePageWidget({required this.user, required this.idToken, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserProfileWidget(
          name: user.name,
          idToken: idToken,
          pictureUrl: user.pictureUrl,
        ),
      ],
    );
  }
}
