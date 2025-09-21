import 'package:flutter/material.dart';
import 'package:fablab_app/presentation/screens/inventory/inventory_screen.dart';
import 'package:fablab_app/presentation/screens/main_home/main_home_screen.dart';
import 'package:fablab_app/presentation/screens/news/news_screen.dart';
import 'package:fablab_app/presentation/screens/profile/profile_screen.dart';
import 'package:fablab_app/presentation/screens/project/project_screen.dart';
import 'package:fablab_app/presentation/screens/request/request_screen.dart';
import 'package:fablab_app/presentation/screens/users/users_screen.dart';
import 'package:fablab_app/presentation/widgets/shared/custom_bottom_navegation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final List<Widget> _screens = const [
    MainHomeScreen(),
    ProjectScreen(),
    UsersScreen(),
    NewsScreen(),
    InventoryScreen(),
  ];


  final ProfileScreen _profileScreen = const ProfileScreen();
  final RequestScreen _requestScreen = const RequestScreen();

  int _selectedIndex = 0;
  bool _showCustomScreen = false; 
  Widget? _customScreen;

  void _navigateToScreen(int index) {
    setState(() {
      _selectedIndex = index;
      _showCustomScreen = false; 
      _customScreen = null;
    });
  }

  void _openProfile() {
    setState(() {
      _customScreen = _profileScreen;
      _showCustomScreen = true;
    });
  }

  void _openRequest() {
    setState(() {
      _customScreen = _requestScreen;
      _showCustomScreen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.person, color: colors.onPrimary),
          onPressed: _openProfile,
        ),
        title: Text(
          "FabLab",
          style: textTheme.titleLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: colors.onPrimary),
            onPressed: _openRequest, 
          ),
        ],
      ),
      body: _showCustomScreen ? _customScreen! : _screens[_selectedIndex],
      bottomNavigationBar: CustomBottomNavegation(
        currentIndex: _selectedIndex,
        onTabSelected: _navigateToScreen,
      ),
    );
  }
}
