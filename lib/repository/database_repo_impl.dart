import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiligrim/models/user.dart';
import 'package:tiligrim/repository/database_repo.dart';
import 'package:tiligrim/services/database_service.dart';

class DatabaseRepositoryImpl extends DatabaseRepository {

  final DatabaseService service = DatabaseService();

  @override
  Future<bool> checkUser(String email){
    return service.checkUser(email);
  }

  @override
  Future<DocumentSnapshot<Map<String, dynamic>>> getData(String email){
    return service.getData(email);
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getChats(String email) {
    return service.getChats(email);
  }

  @override
  Future<void> addData(UserModel userModel){
    return service.addUser(userModel);
  }

  @override
  Future<QuerySnapshot> getUsers(String id){
    return service.getUsers(id);
  }

}