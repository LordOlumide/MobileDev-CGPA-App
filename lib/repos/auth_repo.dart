import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final instance = FirebaseAuth.instance;

  /// To store the user Credentials
  Map<String, dynamic> userCredentials = {
    'userEmail': '',
  };

  createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    await instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => userCredentials['userEmail'] = email);
  }

  logInWithEmailAndPassword(
      {required String email, required String password}) async {
    await instance.signInWithEmailAndPassword(email: email, password: password);
  }
}
