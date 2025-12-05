import 'package:flutter/material.dart';

const colorList = <Color>[
  Color(0xFFFFCC00),
  Colors.red,
  Colors.orange,
  Colors.green,
  Colors.teal,
  Colors.cyan,
  Colors.blue,
  Colors.purple,
  Colors.deepPurple,
  Colors.pink,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 0, this.isDarkMode = false});

  ThemeData getTheme() {
    final primaryColor = colorList[selectedColor];
    final brightness = isDarkMode ? Brightness.dark : Brightness.light;

    if (selectedColor == 0) {
      return ThemeData(
        useMaterial3: true,
        brightness: brightness,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: primaryColor,
          onPrimary: Colors.black,
          secondary: primaryColor,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          surface:
              brightness == Brightness.light
                  ? Colors.white
                  : const Color(0xFF1E1E1E),
          onSurface:
              brightness == Brightness.light ? Colors.black : Colors.white,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black,
          centerTitle: true,
          elevation: 2,
        ),
      );
    }

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorSchemeSeed: primaryColor,
      appBarTheme: const AppBarTheme(centerTitle: true),
    );
  }
}
