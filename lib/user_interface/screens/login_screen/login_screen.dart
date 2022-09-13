import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget{
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
      body: ListView(
        children: [
          // email textfield
          TextField(
          ),

          // password textfield
          TextField(
          ),

          // Login button
          MaterialButton(
            onPressed: () {},
            child: const Text(
              'Log in',
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}