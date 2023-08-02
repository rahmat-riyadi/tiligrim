
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tiligrim/models/user.dart';

class InboxListItem extends StatelessWidget {
  const InboxListItem({super.key, required this.chatUser, required this.onTap, required this.friend});

  final UserModel friend;
  final ChatUser chatUser;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {

    return ListTile(
      onTap: onTap,
      leading: Badge(
        backgroundColor: friend.isActive && false ? Colors.lightGreen : Colors.transparent,
        smallSize: 15,
        child: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(friend.photoUrl.toString()),
        ),
      ),
      title: Text(
        friend.displayName.toString(),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        chatUser.lastChat == null ? 'belum ada chat' : chatUser.lastChat.toString(),
        style: TextStyle(
          fontStyle: chatUser.lastChat == null ? FontStyle.italic : FontStyle.normal
        ),
      ),
      trailing: Column(
        children: [
          Text(
            DateFormat('HH:mm').format(chatUser.lastTime).toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600]
            ),
          ),
          if(chatUser.totalUnread != 0)
          Badge(
            label: Text(
              '${chatUser.totalUnread}',
              style: const TextStyle(
                fontSize: 12
              ),
            ),
            backgroundColor: Colors.green,
            largeSize: 20,
          ),
        ],
      ),
    );
  }
}