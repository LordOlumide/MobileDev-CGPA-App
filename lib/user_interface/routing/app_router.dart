import 'package:flutter/material.dart';

// screens
import '../screens/home_screen/home_screen.dart';
import '../screens/login_screen/login_screen.dart';
import '../screens/registration_screen/registration_screen.dart';
import '../screens/semester_view_screen/semester_view_screen.dart';
import '../screens/welcome_screen/welcome_screen.dart';
import '../screens/course_view_screen/course_view_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());
      case RegistrationScreen.screenId:
        return MaterialPageRoute(
            builder: (context) => const RegistrationScreen());
      case LoginScreen.screenId:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case HomeScreen.screenId:
        return MaterialPageRoute(
            builder: (context) => settings.arguments != null
                ? HomeScreen(userEmail: settings.arguments as String)
                : const HomeScreen());

      case SemesterScreen.screenId:
        return MaterialPageRoute(
            builder: (context) =>
                SemesterScreen(yearResultIndex: settings.arguments as int));

      case CourseScreen.screenId:
        Map argumentsMap = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
            builder: (context) => CourseScreen(
                  yearResultIndex: argumentsMap['yearResultIndex'],
                  isFirstSemester: argumentsMap['isFirstSemester'],
                ));

      default:
        throw Exception('Route not found!');
    }
  }
}
