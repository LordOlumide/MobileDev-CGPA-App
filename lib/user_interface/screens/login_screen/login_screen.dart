import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/constants/constants.dart';
import 'package:mobile_dev_cgpa_app/repos/auth_repo.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // email textfield
            TextField(
              onChanged: (value) {
                email = value;
              },
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(height: 30),

            // password textfield
            TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(height: 30),

            // Login button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () async {
                try {
                  await Provider.of<Auth>(context, listen: false)
                      .logInWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) =>
                          Navigator.pushNamed(context, HomeScreen.screenId));
                } catch (e) {
                  print('FirebaseAuth Error: $e');
                }
              },
              child: const Text(
                'Log in',
                style: TextStyle(),
              ),
            ),
            const SizedBox(height: 20),

            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
