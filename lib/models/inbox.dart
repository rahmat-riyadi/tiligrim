// To parse this JSON data, do
//
//     final inbox = inboxFromJson(jsonString);

import 'dart:convert';

Inbox inboxFromJson(String str) => Inbox.fromJson(json.decode(str));

String inboxToJson(Inbox data) => json.encode(data.toJson());

class Inbox {
    DateTime lastTime;
    String name;
    String connection;
    int totalUnread;

    Inbox({
        required this.lastTime,
        required this.name,
        required this.connection,
        required this.totalUnread,
    });

    factory Inbox.fromJson(Map<String, dynamic> json) => Inbox(
        lastTime: DateTime.parse(json["lastTime"]),
        name: json["name"],
        connection: json["connection"],
        totalUnread: json["total_unread"],
    );

    Map<String, dynamic> toJson() => {
        "lastTime": lastTime.toIso8601String(),
        "name": name,
        "connection": connection,
        "total_unread": totalUnread,
    };
}
