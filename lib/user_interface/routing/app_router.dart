import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/enums.dart';

// screens
import '../../repos/database.dart';
import '../screens/home_screen/home_screen.dart';
import '../screens/authenticate_screen/authenticate_screen.dart';
import '../screens/semester_view_screen/semester_view_screen.dart';
import '../screens/welcome_screen/welcome_screen.dart';
import '../screens/course_view_screen/course_view_screen.dart';

class AppRouter {
  const AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case WelcomeScreen.screenId:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());

      case AuthenticateScreen.screenId:
        return MaterialPageRoute(
            builder: (context) => AuthenticateScreen(
                authAction: settings.arguments as AuthenticationActions));

      case HomeScreen.screenId:
        Database getDatabase() {
          Map args = settings.arguments != null
              ? settings.arguments as Map<String, dynamic>
              : {}; // args: ["withDummyData": bool]
          bool withDummyData = args['withDummyData'] ?? false;
          Database mainDatabase = Database();
          mainDatabase.initialize(withDummyData);
          return mainDatabase;
        }

        // TODO: Implement Load with Dummy data and firestore
        return MaterialPageRoute(builder: (context) {
          return ChangeNotifierProvider(
            create: (context) => getDatabase(),
            child: const HomeScreen(),
          );
        });

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
