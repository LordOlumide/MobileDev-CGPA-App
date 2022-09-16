import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/registration_screen/registration_screen.dart';
import 'package:mobile_dev_cgpa_app/user_interface/screens/welcome_screen/welcome_screen.dart';

// screens
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => WelcomeScreen());
      case RegistrationScreen.screenId:
        return MaterialPageRoute(builder: (context) => RegistrationScreen());
      case LoginScreen.screenId:
        return MaterialPageRoute(builder: (context) => LoginScreen());
      case HomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      default:
        throw Exception('Route not found!');
    }
  }
}
