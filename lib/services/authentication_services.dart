import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationServices {

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  Future<UserCredential?> signIn() async {

    try {

      final GoogleSignInAccount? user = await googleSignIn.signIn();

      final googleAuth = await user!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );

      final userCredential = await auth.signInWithCredential(credential);
      return userCredential;

    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } 

  }

  Future<User?> checkUser() async {
    return auth.currentUser;
  }

  Future<bool> isSignIn() async {
    return googleSignIn.isSignedIn();
  }

  Future<void> signOut() async {
    await googleSignIn.disconnect();
    await googleSignIn.signOut();
    return await auth.signOut();
  }

}