import 'package:cloud_firestore/cloud_firestore.dart';

class ChatServices {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> getInbox(String email) async {

    try {
      final doc = _db.collection('users').doc(email);
      final inbox = doc.get().then((value){
        return value.get('chats');
      });
      return inbox;
    } catch (e) {
      return {
        "status" : "error",
        "message": e.toString()
      };
    }

  }

  Future<dynamic> createConversation(String userEmail, String friendEmail) async {

    bool flagNewConnection = false;
    String date = DateTime.now().toIso8601String();
    CollectionReference conversations = _db.collection("conversations");
    CollectionReference users = _db.collection("users");
    String? chatId;


    try {

      final docChats = await _db.collection("users").doc(userEmail).collection('chats').get();

      if (docChats.docs.isNotEmpty) {
        // user sudah pernah chat dengan siapapun
        final checkConnection = await users
            .doc(userEmail)
            .collection("chats")
            .where("connection", isEqualTo: friendEmail)
            .get();

        if (checkConnection.docs.isNotEmpty) {
          // sudah pernah buat koneksi dengan => friendEmail
          flagNewConnection = false;
          chatId = checkConnection.docs[0].id;

          //chat_id from chats collection
        } else {
          // blm pernah buat koneksi dengan => friendEmail
          // buat koneksi ....
          flagNewConnection = true;
        }
      } else {
        // blm pernah chat dengan siapapun
        // buat koneksi ....
        flagNewConnection = true;
      }

      if (flagNewConnection) {
        // cek dari chats collection => connections => mereka berdua...
        final chatsDocs = await conversations.where(
          "member",
          whereIn: [
            [
              userEmail,
              friendEmail,
            ],
            [
              friendEmail,
              userEmail,
            ],
          ],
        ).get();

        if (chatsDocs.docs.isNotEmpty) {
          // terdapat data chats (sudah ada koneksi antara mereka berdua)
          final chatDataId = chatsDocs.docs[0].id;

          final friendChat = await users.doc(friendEmail).collection("chats").doc(chatDataId).get();
          final friendChatData = friendChat.data();

          await users
            .doc(userEmail)
            .collection("chats")
            .doc(chatDataId)
            .set({
              "connection": friendEmail,
              "lastTime": DateTime.now().toIso8601String(),
              "total_unread": 0,
              "lastChat": friendChatData!["lastChat"],
              "sender": null
            });

          chatId = chatDataId;

        } else {
          // buat baru , mereka berdua benar2 belum ada koneksi
          final newChatDoc = await conversations.add({
            "member": [
              userEmail,
              friendEmail,
            ],
          });

          chatId = newChatDoc.id;

          await conversations.doc(newChatDoc.id).collection("chat");

          final friend = await users.doc(friendEmail).get();
          final friendD = friend.data() as Map<String, dynamic>;

          await users
            .doc(userEmail)
            .collection("chats")
            .doc(newChatDoc.id)
            .set({
              "name": friendD['displayName'],
              "connection": friendD['email'],
              "lastTime": date,
              "total_unread": 0,
              "lastChat": null,
              "sender": null
            });

        }
      }
  
      return chatId;

    } catch (e) {
      return {
        "status" : "error",
        "message": e.toString()
      };
    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> chatStream(String email){
    return _db.collection('users').doc(email).collection('chats').orderBy('lastTime').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> friendStream(String email){
    return _db.collection('users').doc(email).snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> userChat(String id){
    return _db.collection('conversations').doc(id).snapshots(); 
  }

  Future<void> newChat({String? chatId, String? userEmail, String? friendEmail, String? text}) async {

    await _db.collection('conversations').doc(chatId).collection('chat').add({
      "sender": userEmail,
      "reciever": friendEmail,
      "message": text,
      "isRead": false,
      "time": DateTime.now().toIso8601String()
    });

    _db.collection('users').doc(userEmail).collection('chats').doc(chatId).update({
      "lastTime": DateTime.now().toIso8601String(),
      "lastChat": text,
    });

    final friendChat = await _db.collection('users').doc(friendEmail).collection('chats').doc(chatId).get();

    if(friendChat.exists){

      final unreadChat = await _db
                .collection('conversations')
                .doc(chatId)
                .collection('chat')
                .where('isRead', isEqualTo: false)
                .where('sender', isEqualTo: userEmail)
                .get();

      final totalUnread = unreadChat.docs.length;

      await _db.collection('users').doc(friendEmail).collection('chats').doc(chatId).update({
        "lastTime": DateTime.now().toIso8601String(),
        "total_unread": totalUnread,
        "lastChat": text,
      });

    } else {

      await _db.collection('users').doc(friendEmail).collection('chats').doc(chatId).set({
        "connection": userEmail,
        "lastTime": DateTime.now().toIso8601String(),
        "total_unread": 1,
        "lastChat": text,
      });

    }

  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversation(String conversationId){
    return _db.collection('conversations')
          .doc(conversationId)
          .collection('chat')
          .orderBy('time')
          .snapshots();
  }

  Future<void> readChat(chatId, userEmail) async {
    final unreadChats = await _db.collection('conversations')
      .doc(chatId)
      .collection('chat')
      .where('isRead', isEqualTo: false)
      .where('reciever', isEqualTo: userEmail)
      .get();

    unreadChats.docs.forEach((chat) async {
      await _db.collection('conversations').doc(chatId).collection('chat').doc(chat.id).update({ 'isRead' : true });
    });

    await _db.collection('users').doc(userEmail).collection('chats').doc(chatId).update({
      'total_unread': 0
    });


  }

}