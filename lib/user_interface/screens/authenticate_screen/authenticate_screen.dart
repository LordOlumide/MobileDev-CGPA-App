import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/constants/decorations.dart';
import 'package:mobile_dev_cgpa_app/constants/enums.dart';
import 'package:mobile_dev_cgpa_app/repos/auth_repo.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/home_screen/home_screen.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/welcome_screen/welcome_screen.dart';
import 'package:provider/provider.dart';

class AuthenticateScreen extends StatefulWidget {
  static const screenId = 'Authentication screen';

  final AuthenticationActions authAction;

  const AuthenticateScreen({Key? key, required this.authAction})
      : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {
  String email = '';
  String password = '';

  bool inAsyncCall = false;

  login() async {
    await Provider.of<Auth>(context, listen: false)
        .logInWithEmailAndPassword(email: email, password: password)
        .then((_) => Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.screenId,
              ModalRoute.withName(WelcomeScreen.screenId),
            ));
  }

  register() async {
    await Provider.of<Auth>(context, listen: false)
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((_) => Navigator.pushNamedAndRemoveUntil(
              context,
              HomeScreen.screenId,
              ModalRoute.withName(WelcomeScreen.screenId),
            ));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement local login
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
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
                      setState(() {
                        inAsyncCall = true;
                      });
                      try {
                        if (widget.authAction == AuthenticationActions.login) {
                          login();
                        } else {
                          register();
                        }
                      } catch (e) {
                        print(
                            'FirebaseAuth Error: $e'); // TODO: Display information sheet on error
                      }
                      setState(() {
                        inAsyncCall = false;
                      });
                    },
                    child: Text(
                      widget.authAction == AuthenticationActions.login
                          ? 'Log in'
                          : 'Register',
                      style: const TextStyle(
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
                            color:
                                Theme.of(context).textTheme.bodyMedium!.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            inAsyncCall
                ? Container(
                    color: Colors.white54,
                    child: const Center(
                      child:
                          CircularProgressIndicator(color: Colors.blueAccent),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
