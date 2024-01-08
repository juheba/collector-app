import 'package:flutter/material.dart';

class CollectorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CollectorAppBar({
    required this.userName,
    super.key,
    this.userPictureUrl,
  });
  final Uri? userPictureUrl;
  final String userName;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Collector App'),
      actions: [
        if (userName.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  userName,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    debugPrint('Profile Picture Tapped!');
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
