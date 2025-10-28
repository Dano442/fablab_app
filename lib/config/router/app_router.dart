import 'package:fablab_app/presentation/screens/profile/profile_details_screen';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fablab_app/presentation/screens/profile/profile_screen.dart';
import 'package:fablab_app/presentation/screens/profile/profile_themes_screen.dart';
import 'package:fablab_app/presentation/screens/request/request_screen.dart';
import 'package:fablab_app/presentation/screens/home/home_screen.dart';
import 'package:fablab_app/presentation/screens/main_home/main_home_screen.dart';
import 'package:fablab_app/presentation/screens/project/project_screen.dart';
import 'package:fablab_app/presentation/screens/users/users_screen.dart';
import 'package:fablab_app/presentation/screens/news/news_screen.dart';
import 'package:fablab_app/presentation/screens/inventory/inventory_screen.dart';

// 👇 Se necesita esta clave para rutas que van fuera del Shell
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/main_home',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(path: '/main_home', builder: (context, state) => const MainHomeScreen()),
        GoRoute(path: '/projects', builder: (context, state) => const ProjectScreen()),
        GoRoute(path: '/users', builder: (context, state) => const UsersScreen()),
        GoRoute(path: '/news', builder: (context, state) => const NewsScreen()),
        GoRoute(path: '/inventory', builder: (context, state) => const InventoryScreen()),
      ],
    ),

    // --- RUTAS INDEPENDIENTES (fuera del Shell) ---
    GoRoute(
      path: '/profile',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/profile/details',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileDetailsScreen(),
    ),
    GoRoute(
      path: '/profile/themes',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const ProfileThemesScreen(),
    ),
    GoRoute(
      path: '/request',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const RequestScreen(),
    ),
  ],
);
