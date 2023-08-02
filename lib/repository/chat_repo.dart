import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatRepository {

  Future<dynamic> getInbox(String email);
  Future<dynamic> createConversation(String userEmail, String friendEmail);
  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String email);
  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email);
  Stream<DocumentSnapshot<Map<String, dynamic>>> userChat(String id);
  Future<void> newChat({String? chatId, String? userEmail, String? friendEmail, String? text});
  Stream<QuerySnapshot<Map<String, dynamic>>> getConversation(String conversationId);
  Future<void> readChat(chatId, userEmail);
}