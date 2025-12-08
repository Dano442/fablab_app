import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:fablab_app/config/router/app_router.dart';
import 'package:fablab_app/data/services/local_notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.initialize();

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
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedIndex = await _storage.read(key: 'themeIndex');
    final savedDarkMode = await _storage.read(key: 'isDarkMode');

    if (savedIndex != null) {
      _selectedColorIndex = int.tryParse(savedIndex) ?? 0;
    }

    if (savedDarkMode != null) {
      _isDarkMode = savedDarkMode == 'true';
    }

    setState(() {});
  }

  void setTheme(int newIndex) async {
    _selectedColorIndex = newIndex;
    setState(() {});
    await _storage.write(key: 'themeIndex', value: newIndex.toString());
  }

  void setDarkMode(bool value) async {
    _isDarkMode = value;
    setState(() {});
    await _storage.write(key: 'isDarkMode', value: value.toString());
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme(
      selectedColor: _selectedColorIndex,
      isDarkMode: _isDarkMode,
    ).getTheme();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: appRouter,
    );
  }
}
