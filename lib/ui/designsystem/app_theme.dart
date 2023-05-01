import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xFF000000,
      <int, Color>{
        50: Color(0xFFE0E0E0),
        100: Color(0xFFBDBDBD),
        200: Color(0xFF9E9E9E),
        300: Color(0xFF757575),
        400: Color(0xFF616161),
        500: Color(0xFF424242),
        600: Color(0xFF303030),
        700: Color(0xFF212121),
        800: Color(0xFF121212),
        900: Color(0xFF000000),
      },
    ),
  ).copyWith(
    secondary: const Color(0xFF2E7D32),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF4A148C),
    unselectedItemColor: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
  ),
);
