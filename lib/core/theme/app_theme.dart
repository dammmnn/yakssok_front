import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primaryColor = Color(0xFF4A90E2);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),
    useMaterial3: true,
  );
}
