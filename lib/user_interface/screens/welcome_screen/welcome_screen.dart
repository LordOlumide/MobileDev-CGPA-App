import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/login_screen/login_screen.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/registration_screen/registration_screen.dart';
import 'package:mobile_dev_cgpa_app/utils/y_space.dart';

class WelcomeScreen extends StatelessWidget {
  static const screenId = 'Welcome screen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to CGPA App',
              style: TextStyle(fontSize: 30),
            ),
            const YSpace(50),

            // Registration Button
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenId);
              },
              child: Text(
                'Register',
                style: TextStyle(),
              ),
            ),
            const YSpace(50),

            // Login button
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.screenId);
              },
              child: Text(
                'Log in',
                style: TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
