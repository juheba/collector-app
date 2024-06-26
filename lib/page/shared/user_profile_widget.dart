import 'package:flutter/material.dart';

class MockUser {
  static const String name = 'Name Mockname';
  static const String idToken = 'bearerJWT12345678910111213';
  static final Uri pictureUrl = Uri.parse(
    'https://miro.medium.com/v2/resize:fit:720/format:webp/0*vowtRZE_wvyVA7CB',
  );
}

class MockUserWidget extends StatelessWidget {
  const MockUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return UserProfileWidget(
      name: MockUser.name,
      idToken: MockUser.idToken,
      pictureUrl: MockUser.pictureUrl,
    );
  }
}

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({
    required this.name,
    required this.idToken,
    this.pictureUrl,
    super.key,
  });
  final String? name;
  final String idToken;
  final Uri? pictureUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
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
                child: ClipOval(
                  child: Image.network(
                    pictureUrl.toString(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
