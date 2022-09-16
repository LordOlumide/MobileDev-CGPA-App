import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final instance = FirebaseAuth.instance;

  registerNewUser({required String email, required String password}) async {
    await instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
