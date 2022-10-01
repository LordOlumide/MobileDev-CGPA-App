import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/constants/enums.dart';
import '../authenticate_screen/authenticate_screen.dart';
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
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w800,
                color: Theme.of(context).textTheme.bodyMedium!.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),

            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.screenId);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'Use Offline',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Registration Button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AuthenticateScreen.screenId,
                  arguments: AuthenticationActions.register,
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Login button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AuthenticateScreen.screenId,
                  arguments: AuthenticationActions.login,
                );
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
