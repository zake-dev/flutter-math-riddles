import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: const Color(0xFF111111),
  // primaryColorDark: Colors.black,
  primaryColorDark: const Color(0xFF130C12),
  brightness: Brightness.dark,
  accentColorBrightness: Brightness.light,
  backgroundColor: const Color(0xFF111111),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
  canvasColor: Color(0xFFD1CAC3),
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: const Color(0xFFFFFDF7),
  primaryColorDark: const Color(0xFFFFFDEB),
  brightness: Brightness.light,
  accentColorBrightness: Brightness.dark,
  backgroundColor: const Color(0xFFFFFDF7),
  accentColor: Color(0xFF110A03),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
  canvasColor: Color(0xFF413A33),
);
