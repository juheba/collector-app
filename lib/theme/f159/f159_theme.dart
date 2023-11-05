import 'package:flutter/material.dart';

class ColorCombination {
  final Color primary;
  final Color secondary;
  final Color button;
  final Color text;

  const ColorCombination._(this.primary, this.secondary, this.button, this.text);

  static const combination1 =
      ColorCombination._(Color(0xFF2C3368), Color(0xFFEEA351), Color(0xFFC12D66), Color(0xFFEED67A));
}

class F159DarkTheme {
  final ColorCombination colors;
  late ThemeData themeData;

  F159DarkTheme._(this.colors) {
    themeData = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme(
        primary: colors.primary,
        secondary: colors.secondary,
        surface: const Color(0xFF121212),
        background: const Color(0xFF121212),
        error: Colors.red,
        onPrimary: colors.text,
        onSecondary: colors.text,
        onSurface: colors.text,
        onBackground: colors.text,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.text),
        bodyMedium: TextStyle(color: colors.text),
        bodySmall: TextStyle(color: colors.secondary),
        displayLarge: TextStyle(color: colors.text),
        displayMedium: TextStyle(color: colors.text),
        displaySmall: TextStyle(color: colors.text),
        headlineMedium: TextStyle(color: colors.text),
        headlineSmall: TextStyle(color: colors.text),
        titleLarge: TextStyle(color: colors.text),
        titleMedium: TextStyle(color: colors.text),
        titleSmall: TextStyle(color: colors.text),
        labelLarge: TextStyle(color: colors.primary),
        labelSmall: TextStyle(color: colors.secondary),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: colors.button,
        textTheme: ButtonTextTheme.primary,
      ),
      primaryIconTheme: IconThemeData(
        color: colors.text,
      ),
      iconTheme: IconThemeData(
        color: colors.secondary,
      ),
      appBarTheme: AppBarTheme(
        color: colors.primary,
        iconTheme: IconThemeData(
          color: colors.text,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colors.secondary,
        foregroundColor: colors.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colors.secondary),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        hintStyle: TextStyle(color: colors.text.withOpacity(0.5)),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: colors.secondary,
        inactiveTrackColor: colors.primary.withOpacity(0.5),
        thumbColor: colors.secondary,
      ),
    );
  }

  static final combination1 = F159DarkTheme._(ColorCombination.combination1);
}
