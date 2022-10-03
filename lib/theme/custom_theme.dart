import 'package:flutter/material.dart';

class CustomTheme {
  static const Color primary = Color(0xFF4daff6);
  static final Decoration cardStyle = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
  );
  final customTheme = ThemeData.light().copyWith(
    primaryColor: primary,
    appBarTheme: const AppBarTheme(backgroundColor: primary),
    scaffoldBackgroundColor: const Color(0xFFe7eeee),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: primary,
      ),
    ),
  );
}
