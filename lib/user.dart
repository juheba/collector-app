import 'package:flutter/material.dart';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/services.dart';

class UserWidget extends StatelessWidget {
  final UserProfile user;
  final String idToken;

  const UserWidget({required this.user, required this.idToken, final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pictureUrl = user.pictureUrl;
    // id, name, email, email verified, updated_at
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (pictureUrl != null)
          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: CircleAvatar(
                radius: 56,
                child: ClipOval(child: Image.network(pictureUrl.toString())),
              ),
            ),
          ),
        Card(
          child: Column(
            children: [
              UserEntryWidget(propertyName: 'Id', propertyValue: user.sub),
              UserEntryWidget(propertyName: 'Name', propertyValue: user.name),
              UserEntryWidget(propertyName: 'Email', propertyValue: user.email),
              UserEntryWidget(
                  propertyName: 'Email Verified?',
                  propertyValue: user.isEmailVerified.toString()),
              UserEntryWidget(
                  propertyName: 'Updated at',
                  propertyValue: user.updatedAt?.toIso8601String()),
            ],
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () => copyToken(context),
                  child: const Text('Copy Token')),
              SelectableText(idToken)
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
  final String propertyName;
  final String? propertyValue;

  const UserEntryWidget(
      {required this.propertyName, required this.propertyValue, final Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text(propertyName), Text(propertyValue ?? '')],
        ));
  }
}
