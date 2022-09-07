import 'package:flutter/material.dart';
// screens
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.screenId:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      case LoginScreen.screenId:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      default:
        throw Exception('Route not found!');
    }
  }

}
