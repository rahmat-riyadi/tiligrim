import 'package:firebase_auth/firebase_auth.dart';
import 'package:tiligrim/repository/authentication_repo.dart';
import 'package:tiligrim/services/authentication_services.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {

  AuthenticationServices services = AuthenticationServices();

  @override
  Future<UserCredential?> signIn(){
    try {
      return services.signIn();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    }
  }

  @override
  Future<void> signOut(){
    return services.signOut();
  }

  @override
  Future<User?> checkUser(){
    return services.checkUser();
  }

  @override
  Future<bool> isSignIn(){
    return services.isSignIn();
  }

}