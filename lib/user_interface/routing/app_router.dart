import 'package:flutter/material.dart';
// screens
import '../screens/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomeScreen.screenId:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        throw Exception('Route not found!');
    }
  }

}
