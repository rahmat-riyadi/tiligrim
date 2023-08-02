// To parse this JSON data, do
//
//     final conversation = conversationFromJson(jsonString);

import 'dart:convert';

import 'package:tiligrim/models/chat.dart';

Conversation conversationFromJson(String str) => Conversation.fromJson(json.decode(str));

String conversationToJson(Conversation data) => json.encode(data.toJson());

class Conversation {
    List<String> connections;
    List<Chat> chat;

    Conversation({
        required this.connections,
        required this.chat,
    });

    factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
        connections: List<String>.from(json["connections"].map((x) => x)),
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "connections": List<dynamic>.from(connections.map((x) => x)),
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
    };
}

