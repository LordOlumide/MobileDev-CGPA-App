import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Helpers
import '../user_interface/routing/app_router.dart';

class Auth {
  late final instance;

  void initializeInstance() {
    instance = FirebaseAuth.instance;
  }

  registerNewUser({required String email, required String password}) async {
    await instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }
}
