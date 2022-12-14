import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightPrimaryColor = const Color(0xffd5f8cc);
  static Color lightSecondaryColor = const Color(0xffdfe5ff);
  static Color lightBackgroundColor = const Color(0xffc7c7c7);
  static Color lightFloatingActionButtonColor = const Color(0xffb3cef8);
  static Color lightScaffoldBackgroundColor = const Color(0xfffefff2);
  static Color lightTextColor = Colors.black87;

  static Color darkPrimaryColor =
      const Color(0xFF232323); // TODO: Enable dark theme
  static Color darkSecondaryColor = const Color(0xFF7700b2);
  static Color darkBackgroundColor = const Color(0xffbcbcbc);
  static Color darkFloatingActionButtonColor = const Color(0xFFb41eff);

  const AppTheme._();

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static final lightTheme = ThemeData(
    // colorScheme: ColorScheme.fromSwatch(
    //   primarySwatch: Colors.blue,
    // ).copyWith(
    //   secondary: const Color(0xFFD9614C),
    // ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      background: lightBackgroundColor,
    ),
    fontFamily: 'Nunito',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightFloatingActionButtonColor,
    ),
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: lightTextColor),
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      background: darkBackgroundColor,
    ),
    fontFamily: 'Nunito',
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: darkFloatingActionButtonColor,
    ),
  );

  static setStatusAndNavigationBarColors(ThemeMode themeMode) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness:
          themeMode == ThemeMode.light ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: themeMode == ThemeMode.light
          ? lightBackgroundColor
          : darkBackgroundColor,
      systemNavigationBarDividerColor: Colors.transparent,
    ));
  }

  static void refreshSystemOverlay() {
    AppTheme.currentSystemBrightness == Brightness.light
        ? AppTheme.setStatusAndNavigationBarColors(ThemeMode.light)
        : AppTheme.setStatusAndNavigationBarColors(ThemeMode.dark);
  }
}
