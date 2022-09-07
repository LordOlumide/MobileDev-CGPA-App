import 'package:flutter/material.dart';
import 'user_interface/routing/app_router.dart';
import 'constants/app_theme.dart';
// screens
import 'user_interface/screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyCGPAApp());
}

class MyCGPAApp extends StatelessWidget {
  const MyCGPAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: HomeScreen.screenId,
    );
  }
}

