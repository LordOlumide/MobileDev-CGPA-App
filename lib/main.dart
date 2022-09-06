import 'package:flutter/material.dart';
// helpers
import 'user_interface/routing/app_router.dart';
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: HomeScreen.screenId,
    );
  }
}

