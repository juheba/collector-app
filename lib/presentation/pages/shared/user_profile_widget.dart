import 'package:flutter/material.dart';

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
