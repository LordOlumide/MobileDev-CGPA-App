import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget{
  static const screenId = 'Login screen';
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // email textfield
          TextField(
            controller: emailController,
          ),

          // password textfield
          TextField(
            controller: passwordController,
          ),

          // Login button
          MaterialButton(
            onPressed: () {},
            child: Text(
              'Log in',
              style: TextStyle(),
            ),
          ),
        ],
      ),
    );
  }
}