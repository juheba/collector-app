import 'package:flutter/material.dart';

class MockUserWidget extends StatelessWidget {
  const MockUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProfileWidget(
      name: 'Name Mockname',
      idToken: 'bearerJWT12345678910111213',
      pictureUrl: Uri.parse(
        'https://upload.wikimedia.org/wikipedia/commons/4/4f/Dash%2C_the_mascot_of_the_Dart_programming_language.png',
      ),
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  final String? name;
  final String idToken;
  final Uri? pictureUrl;

  const UserProfileWidget({
    required this.name,
    required this.idToken,
    this.pictureUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name ?? ''),
                const SizedBox(
                  height: 10,
                ),
                Text('${idToken.substring(0, 20)}...'),
              ],
            ),
            const Spacer(),
            if (pictureUrl != null)
              CircleAvatar(
                radius: 30,
                child: ClipOval(child: Image.network(pictureUrl.toString())),
              ),
          ],
        ),
      ),
    );
  }
}
