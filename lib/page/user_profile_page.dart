// '/profile' wenn logged in

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserPageWidget extends StatelessWidget {
  const UserPageWidget({
    required this.user,
    required this.idToken,
    super.key,
  });
  final UserProfile user;
  final String idToken;

  @override
  Widget build(BuildContext context) {
    final pictureUrl = user.pictureUrl;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pictureUrl != null)
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: CircleAvatar(
                radius: 56,
                child: ClipOval(
                  child: Image.network(pictureUrl.toString()),
                ),
              ),
            ),
          ),
        Card(
          child: Column(
            children: [
              UserEntryWidget(propertyName: 'Id', propertyValue: user.sub),
              UserEntryWidget(propertyName: 'Name', propertyValue: user.name),
              UserEntryWidget(propertyName: 'Email', propertyValue: user.email),
            ],
          ),
        ),
        Card(
          child: Column(
            children: [
              TextButton(
                onPressed: () => copyToken(context),
                child: const Text('Copy Token'),
              ),
              SelectableText(idToken),
            ],
          ),
        ),
      ],
    );
  }

  void copyToken(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Token copied to clipboard.'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Clipboard.setData(ClipboardData(text: idToken));
  }
}

class UserEntryWidget extends StatelessWidget {
  const UserEntryWidget({
    required this.propertyName,
    required this.propertyValue,
    super.key,
  });
  final String propertyName;
  final String? propertyValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(propertyName),
          Text(propertyValue ?? ''),
        ],
      ),
    );
  }
}
