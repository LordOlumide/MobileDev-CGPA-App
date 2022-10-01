import 'package:flutter/material.dart';
import 'package:mobile_dev_cgpa_app/models/course_result.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
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

  final directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CourseResultAdapter());

  runApp(
    const MyCGPAApp(),
  );
}

class MyCGPAApp extends StatefulWidget {
  const MyCGPAApp({super.key});

  @override
  State<MyCGPAApp> createState() => _MyCGPAAppState();
}

class _MyCGPAAppState extends State<MyCGPAApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Auth(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: WelcomeScreen.screenId,
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('courses').compact();
    Hive.box('courses').close();
    super.dispose();
  }
}
