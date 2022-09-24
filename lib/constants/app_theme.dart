import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static Color lightPrimaryColor = const Color(0xFFffffff);
  static Color lightSecondaryColor = const Color(0xFF006fff);
  static Color lightBackgroundColor = const Color(0xffc7c7c7);
  static Color lightFloatingActionButtonColor = const Color(0xFF7c7c7c);

  static Color darkPrimaryColor = const Color(0xFF232323);
  static Color darkSecondaryColor = const Color(0xFF7700b2);
  static Color darkBackgroundColor = const Color(0xffbcbcbc);
  static Color darkFloatingActionButtonColor = const Color(0xFFb41eff);

  const AppTheme._();

  static Brightness get currentSystemBrightness =>
      SchedulerBinding.instance.window.platformBrightness;

  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: lightPrimaryColor,
      secondary: lightSecondaryColor,
      background: lightBackgroundColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightFloatingActionButtonColor,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: darkPrimaryColor,
      secondary: darkSecondaryColor,
      background: darkBackgroundColor,
    ),
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