import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobile_dev_cgpa_app/constants/decorations.dart';
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
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  hintText: 'Enter your password.',
                ),
                cursorColor: Colors.black87,
              ),
              const SizedBox(height: 30),

              // "Registration" button
              MaterialButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                onPressed: () async {
                  try {
                    await Provider.of<Auth>(context, listen: false)
                        .createUserWithEmailAndPassword(
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
                  'Register',
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
