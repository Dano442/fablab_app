import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:fablab_app/config/router/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
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
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }


  Future<void> _loadTheme() async {
    final savedIndex = await _storage.read(key: 'themeIndex');
    if (savedIndex != null) {
      setState(() {
        _selectedColorIndex = int.tryParse(savedIndex) ?? 0;
      });
    }
  }

  /// Cambia y guarda el nuevo tema
  void setTheme(int newIndex) async {
    setState(() {
      _selectedColorIndex = newIndex;
    });
    await _storage.write(key: 'themeIndex', value: newIndex.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(selectedColor: _selectedColorIndex).getTheme();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter,
    );
  }
}
