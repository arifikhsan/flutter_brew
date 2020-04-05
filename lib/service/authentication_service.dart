import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_brew/model/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> signInAnonymous() async {
    try {
      AuthResult authResult = await _firebaseAuth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Stream<User> get user =>
      _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);

  User _userFromFirebaseUser(FirebaseUser firebaseUser) {
    return firebaseUser == null ? null : User(uid: firebaseUser.uid);
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
