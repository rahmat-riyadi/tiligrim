
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiligrim/models/user.dart';

class DatabaseService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<bool> checkUser(String email) async {
    final res = await _db.collection('users').doc(email).get();
    return res.exists;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData(String email) async {
    final data = await _db.collection('users').doc(email).get();
    return data;
  }

  Future<QuerySnapshot<Map<String, dynamic>>>  getChats(String email) async {
    final data = await _db.collection('users').doc(email).collection('chats').get();
    return data;
  }

  Future<void> addUser(UserModel userModel) async {
    await _db.collection('users').doc(userModel.email).set(userModel.toJson());
    _db.collection('users').doc(userModel.email).collection('chats');
  }

  Future<QuerySnapshot> getUsers(String id){
    return _db.collection('users').where('id', isNotEqualTo: id).get();
  }

}