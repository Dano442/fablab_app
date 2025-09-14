import 'package:fablab_app/presentation/screens/inventory/inventory_screen.dart';
import 'package:fablab_app/presentation/screens/main_home/main_home_screen.dart';
import 'package:fablab_app/presentation/screens/news/news_screen.dart';
import 'package:fablab_app/presentation/screens/projects/projects_screen.dart';
import 'package:fablab_app/presentation/screens/users/users_screen.dart';
import 'package:fablab_app/presentation/widgets/shared/custom_bottom_navegation.dart';
import 'package:flutter/material.dart';
import 'package:fablab_app/presentation/widgets/widgets.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
  int selectedIndex = 0;
class _HomeScreenState extends State<HomeScreen> {

  final screens = [
    MainHomeScreen(),
    ProjectsScreen(),  
    UsersScreen(),
    NewsScreen(),
    InventoryScreen(),
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: CustomBottomNavegation(
        currentIndex: selectedIndex,
        onTabSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }
}

