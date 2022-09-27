import 'package:flutter/material.dart';
import '../login_screen/login_screen.dart';
import '../registration_screen/registration_screen.dart';
import '../home_screen/home_screen.dart';

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
            const SizedBox(height: 50),

            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onPressed: () {
                Navigator.pushReplacementNamed(context, HomeScreen.screenId);
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'Use Offline',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Registration Button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.screenId);
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Login button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.screenId);
              },
              color: Theme.of(context).colorScheme.primary,
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
