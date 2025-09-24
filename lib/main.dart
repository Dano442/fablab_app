// Archivo: main.dart
import 'package:fablab_app/presentation/screens/home/home_screen.dart';
import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => MainAppState();

  static MainAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MainAppState>()!;
}

class MainAppState extends State<MainApp> {
  int _selectedColorIndex = 0;


  void setTheme(int newIndex) {
    setState(() {
      _selectedColorIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme(selectedColor: _selectedColorIndex).getTheme(),
      home: const HomeScreen(),
    );
  }
}