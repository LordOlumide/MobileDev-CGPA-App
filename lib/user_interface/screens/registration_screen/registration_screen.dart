import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/constants/constants.dart';
import '../../../repos/auth_repo.dart';

// screens
import '../home_screen/home_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const screenId = 'Registration screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                hintText: 'Enter your password.',
              ),
            ),
            const SizedBox(height: 30),

            // "Registration" button
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              onPressed: () async {
                try {
                  await Provider.of<Auth>(context, listen: false)
                      .createUserWithEmailAndPassword(
                          email: email, password: password)
                      .then((value) =>
                          Navigator.pushNamed(context, HomeScreen.screenId));
                } catch (e) {
                  print('FirebaseAuth Error: $e');
                }
              },
              child: const Text(
                'Register',
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
