import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  runApp(const MyCGPAApp());
}

class MyCGPAApp extends StatefulWidget {
  const MyCGPAApp({super.key});

  @override
  State<MyCGPAApp> createState() => _MyCGPAAppState();
}

class _MyCGPAAppState extends State<MyCGPAApp> {
  Database mainDatabase = Database();

  @override
  void initState() {
    super.initState();
    mainDatabase.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Auth()),
        ChangeNotifierProvider(create: (context) => mainDatabase),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        // darkTheme: AppTheme.darkTheme,
        onGenerateRoute: AppRouter.onGenerateRoute,
        // initialRoute: WelcomeScreen.screenId,
        initialRoute: HomeScreen.screenId,
      ),
    );
  }
}

