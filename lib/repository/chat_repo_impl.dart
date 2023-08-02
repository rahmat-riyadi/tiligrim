import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiligrim/services/chat_services.dart';

import 'chat_repo.dart';

class ChatRepositoryImpl extends ChatRepository {

  final ChatServices service = ChatServices();

  @override
  Future<dynamic> getInbox(String email){
    return service.getInbox(email);
  }

  @override
  Future<dynamic> createConversation(String userEmail, String friendEmail){
    return service.createConversation(userEmail, friendEmail);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String email){
    return service.chatStream(email);
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email){
    return service.friendStream(email);
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> userChat(String id){
    return service.userChat(id);
  }

  @override
  Future<void> newChat({String? chatId, String? userEmail, String? friendEmail, String? text}){
    return service.newChat(chatId: chatId, userEmail: userEmail, friendEmail: friendEmail, text: text);
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversation(String conversationId){
    return service.getConversation(conversationId);
  }

  @override
  Future<void> readChat(chatId, userEmail){
    return service.readChat(chatId, userEmail);
  }

}