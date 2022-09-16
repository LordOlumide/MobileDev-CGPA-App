import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/home_screen/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const screenId = 'Login screen';

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: [
            // email textfield
            TextField(),

            // password textfield
            TextField(),

            // Login button
            MaterialButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password)
                    .then((value) =>
                        Navigator.pushNamed(context, HomeScreen.screenId))
                    .onError((error, stackTrace) => print('Error: $error'));
              },
              child: const Text(
                'Log in',
                style: TextStyle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
