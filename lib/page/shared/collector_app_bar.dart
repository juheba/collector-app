import 'package:flutter/material.dart';

class CollectorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Uri? userPictureUrl;
  final String userName;

  const CollectorAppBar({super.key, this.userPictureUrl, required this.userName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.teal,
      title: const Text('Collector App'),
      actions: [
        if (userName.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(userName, style: const TextStyle(color: Colors.white, fontSize: 16)),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    print('Profile Picture Tapped!');
                  },
                  child: CircleAvatar(
                    backgroundImage: userPictureUrl != null ? NetworkImage(userPictureUrl.toString()) : null,
                    radius: 20,
                    child: userPictureUrl == null ? const Icon(Icons.person, size: 30, color: Colors.white) : null,
                  ),
                ),
              ],
            ),
          ),
      ],

/*      actions: [
        Container(
          margin: const EdgeInsets.only(right: 12.0),
          child: GestureDetector(
            onTap: () {
              // Add action on profile picture tap if needed
              print('Profile Picture Tapped!');
            },
            child: CircleAvatar(
              backgroundImage: userPictureUrl != null ? NetworkImage(userPictureUrl as String) : null,
              radius: 20, // Add your fallback asset image here if needed
              child: userPictureUrl == null ? const Icon(Icons.person, size: 30, color: Colors.white) : null,
            ),
          ),
        ),
      ],*/
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
