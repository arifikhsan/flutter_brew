import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future signInAnonymous() async {
    try {
      AuthResult authResult = await firebaseAuth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;
      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
