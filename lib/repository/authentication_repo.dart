import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationRepository {
  
  Future<UserCredential?> signIn();
  Future<void> signOut();
  Future<User?> checkUser();
  Future<bool> isSignIn();

}