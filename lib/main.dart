import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// helpers
import 'repos/auth_repo.dart';
// services
import 'user_interface/routing/app_router.dart';
import 'constants/app_theme.dart';
// screens
import 'user_interface/screens/welcome_screen/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyCGPAApp());
}

class MyCGPAApp extends StatelessWidget {
  MyCGPAApp({super.key});
  //
  // final globalAuthInstance = Auth();
  // globalAuthInstance.initializeInstancee();
  //

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: WelcomeScreen.screenId,
    );
  }
}

