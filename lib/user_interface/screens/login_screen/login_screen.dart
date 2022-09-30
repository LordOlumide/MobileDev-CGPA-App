import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/constants/decorations.dart';
import 'package:mobile_dev_cgpa_app/repos/auth_repo.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/home_screen/home_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const screenId = 'Login screen';

  const LoginScreen({Key? key}) : super(key: key);

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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
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
                cursorColor: Colors.black87,
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
                cursorColor: Colors.black87,
              ),
              const SizedBox(height: 30),

              // Login button
              MaterialButton(
                // TODO: Add loading animation for login and registration
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  try {
                    await Provider.of<Auth>(context, listen: false)
                        .logInWithEmailAndPassword(
                            email: email, password: password)
                        .then((value) => Navigator.pushNamedAndRemoveUntil(
                            context,
                            HomeScreen.screenId,
                            (Route<dynamic> route) => false,
                            arguments: email));
                  } catch (e) {
                    print('FirebaseAuth Error: $e');
                  }
                },
                child: const Text(
                  'Log in',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Go back',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
