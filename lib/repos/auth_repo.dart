import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  late final instance;

  void initializeInstance() {
    instance = FirebaseAuth.instance;
  }

  registerNewUser(String email, String password) async {
    final newUser = await instance.createUserWithEmailAndPassword(
        email: email, password: password);
    if (newUser != null) {
      Navigator.pushNamed(context, ChatScreen.screen_id);
    }
  }
}