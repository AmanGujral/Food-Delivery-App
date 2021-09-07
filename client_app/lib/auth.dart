import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User get currentUser => _firebaseAuth.currentUser;

  Future<void> signInAnonymously() async {
    await _firebaseAuth.signInAnonymously();
  }

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {String email, String password}) async {
    await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
