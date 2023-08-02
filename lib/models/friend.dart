import 'dart:convert';

class FriendModel {

  String displayName;
  String email;
  String photoUrl;
  String id;
  bool isActive;

  String FriendModelToJson(FriendModel data) => json.encode(data.toJson());

  FriendModel({
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.id,
    this.isActive = false,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json){
    return FriendModel(
      email: json['email'], 
      displayName: json['displayName'],
      photoUrl: json['photoUrl'], 
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "email": email,
      "displayName": displayName,
      "photoUrl": photoUrl,
    };
  }


}