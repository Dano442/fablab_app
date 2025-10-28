import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fablab_app/presentation/widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  final Widget child; 

  const HomeScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

  
    final String location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);
    final showBottomNav = currentIndex != -1;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 2,
        leading: IconButton(
          icon: Icon(Icons.person, color: colors.onPrimary),
          onPressed: () => context.go('/profile'),
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
            onPressed: () => context.go('/request'),
          ),
        ],
      ),


      body: child,

      // Barra de navegación inferior
      bottomNavigationBar: showBottomNav
          ? CustomBottomNavigation(
              currentIndex: currentIndex,
              onTabSelected: (index) => _onItemTapped(context, index),
            )
          : null,
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/main_home');
        break;
      case 1:
        context.go('/projects');
        break;
      case 2:
        context.go('/users');
        break;
      case 3:
        context.go('/news');
        break;
      case 4:
        context.go('/inventory');
        break;
    }
  }

  int _getCurrentIndex(String location) {
    if (location.startsWith('/main_home')) return 0;
    if (location.startsWith('/projects')) return 1;
    if (location.startsWith('/users')) return 2;
    if (location.startsWith('/news')) return 3;
    if (location.startsWith('/inventory')) return 4;
    return -1;
  }
}
