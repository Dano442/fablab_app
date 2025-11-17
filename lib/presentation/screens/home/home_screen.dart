import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fablab_app/presentation/widgets/shared/custom_bottom_navigation.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;

  const HomeScreen({super.key, required this.child});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final String location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getCurrentIndex(location);
    final showBottomNav = currentIndex != -1;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        final router = GoRouter.of(context);
        final currentRoute = router.routeInformationProvider.value.uri.toString();

        if (currentRoute != '/main_home') {
          router.go('/main_home');
          return;
        }

        final now = DateTime.now();
        if (_lastBackPressed == null || now.difference(_lastBackPressed!) > const Duration(seconds: 2)) {
          _lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Presiona nuevamente para salir'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        SystemNavigator.pop();
      },
      child: Scaffold(
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
        body: widget.child,
        bottomNavigationBar: showBottomNav
            ? CustomBottomNavigation(
                currentIndex: currentIndex,
                onTabSelected: (index) => _onItemTapped(context, index),
              )
            : null,
      ),
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
