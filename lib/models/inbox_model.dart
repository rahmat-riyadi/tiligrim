// To parse this JSON data, do
//
//     final inbox = inboxFromJson(jsonString);

import 'dart:convert';

Inbox inboxFromJson(String str) => Inbox.fromJson(json.decode(str));

String inboxToJson(Inbox data) => json.encode(data.toJson());

class Inbox {
    String? name;
    String? conversationId;
    String? lastTime;
    int? totalUnread;
    String? friendAvatar;
    String? lastChat;

    Inbox({
        required this.name,
        required this.conversationId,
        required this.lastTime,
        required this.totalUnread,
        required this.friendAvatar,
        required this.lastChat,
    });

    factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
        name: json["name"],
        conversationId: json["conversation_id"],
        lastTime: json["lastTime"],
        totalUnread: json["total_unread"],
        friendAvatar: json["friend_avatar"],
        lastChat: json["last_chat"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "conversation_id": conversationId,
        "lastTime": lastTime,
        "total_unread": totalUnread,
        "friend_avatar": friendAvatar,
        "last_chat": lastChat,
    };
}
