// '/' wenn logged in

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:collector/page/shared/user_profile_widget.dart';
import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    required this.user,
    required this.idToken,
    super.key,
  });
  final UserProfile user;
  final String idToken;

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
