
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiligrim/models/user.dart';

abstract class DatabaseRepository {

  Future<bool> checkUser(String email);
  Future<DocumentSnapshot<Map<String, dynamic>>> getData(String email);
  Future<QuerySnapshot<Map<String, dynamic>>> getChats(String email);
  Future<void> addData(UserModel userModel);
  Future<QuerySnapshot> getUsers(String id);

}