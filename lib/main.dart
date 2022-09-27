import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:firebase_core/firebase_core.dart';

// helpers
import 'repos/auth_repo.dart';
import 'package:mobile_dev_cgpa_app/repos/database.dart';

// services
import 'user_interface/routing/app_router.dart';
import 'constants/app_theme.dart';

// screens
import 'user_interface/screens/welcome_screen/welcome_screen.dart';
import 'user_interface/screens/home_screen/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Database mainDatabase = Database();
  mainDatabase.initialize();

  final directory = await path_provider.getApplicationDocumentsDirectory();
  print('Type is: ${directory.runtimeType}');
  Hive.init(directory.path);

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => mainDatabase),
      ],
      child: const MyCGPAApp(),
    ),
  );
}

class MyCGPAApp extends StatelessWidget {
  const MyCGPAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: WelcomeScreen.screenId,
    );
  }
}
