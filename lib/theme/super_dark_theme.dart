import 'package:flutter/material.dart';

final ThemeData superDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.black,
  colorScheme: const ColorScheme.dark(
    primary: Colors.black,
    secondary: Colors.deepPurpleAccent,
  ),
  cardColor: Colors.grey[900],
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
    bodyLarge: TextStyle(fontSize: 14.0, color: Colors.white),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
);
