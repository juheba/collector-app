import 'package:flutter/material.dart';

final ThemeData modernDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  primaryColor: Colors.grey[850],
  colorScheme: ColorScheme.dark(
    primary: Colors.grey[850]!,
    secondary: Colors.tealAccent,
  ),
  cardColor: Colors.grey[800],
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 14, color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    foregroundColor: Colors.white,
  ),
);
