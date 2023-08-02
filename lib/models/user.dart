import 'dart:convert';

class UserModel {

  String displayName;
  String email;
  String photoUrl;
  String id;
  bool isActive;
  List<ChatUser> chats;

  String userModelToJson(UserModel data) => json.encode(data.toJson());

  UserModel({
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.id,
    required this.chats,
    this.isActive = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      email: json['email'], 
      displayName: json['displayName'],
      photoUrl: json['photoUrl'], 
      id: json['id'],
      chats: json['chats'] != null || (json['chats'].length == 0) ? List<ChatUser>.from(json['chats'].map((e) => ChatUser.fromJson(e))) : [],
      isActive: json['is_active']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
      "chats": List<dynamic>.from(chats.map((e) => e.toJson())),
      "is_active": isActive
    };
  }


}

class ChatUser {
    String email;
    String conversationId;
    DateTime lastTime;
    int? totalUnread;
    String? lastChat;

    ChatUser({
        required this.email,
        required this.conversationId,
        required this.lastTime,
        required this.totalUnread,
        required this.lastChat,
    });

    factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        email: json["connection"],
        conversationId: json["conversation_id"],
        lastTime: DateTime.parse(json["lastTime"]),
        lastChat: json["lastChat"],
        totalUnread: json["total_unread"],
    );

    Map<String, dynamic> toJson() => {
        "connection": email,
        "conversation_id": conversationId,
        "lastTime": lastTime.toIso8601String(),
        "lastChat": lastChat,
        "total_unread": totalUnread,
    };
}