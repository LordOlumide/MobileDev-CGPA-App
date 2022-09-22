import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final instance = FirebaseAuth.instance;

  createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  logInWithEmailAndPassword(
      {required String email, required String password}) async {
    await instance.signInWithEmailAndPassword(email: email, password: password);
  }
}
