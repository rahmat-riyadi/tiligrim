import 'package:flutter/material.dart';
import 'package:tiligrim/models/friend.dart';

class FriendListItem extends StatelessWidget {
  const FriendListItem({super.key, required this.user, required this.onTap});

  final FriendModel user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(
          user.photoUrl
        ),
        radius: 28,
      ),
      title: Text(
        user.displayName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(user.email),
    );
  }
}