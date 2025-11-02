import 'package:fablab_app/presentation/screens/profile/profile_details_screen';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// --- Autenticación ---
import 'package:fablab_app/presentation/screens/auth/login_screen.dart';
import 'package:fablab_app/presentation/screens/auth/splash_screen.dart';

//  Perfil 
import 'package:fablab_app/presentation/screens/profile/profile_screen.dart';
import 'package:fablab_app/presentation/screens/profile/profile_themes_screen.dart';

//  Solicitudes 
import 'package:fablab_app/presentation/screens/request/request_screen.dart';

//  Home y navegación principal 
import 'package:fablab_app/presentation/screens/home/home_screen.dart';
import 'package:fablab_app/presentation/screens/main_home/main_home_screen.dart';
import 'package:fablab_app/presentation/screens/project/project_screen.dart';
import 'package:fablab_app/presentation/screens/users/users_screen.dart';
import 'package:fablab_app/presentation/screens/news/news_screen.dart';
import 'package:fablab_app/presentation/screens/inventory/inventory_screen.dart';

/// Clave global para controlar la navegación raíz
final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// Rutas principales de la aplicación FabLab
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,

  /// Ahora iniciamos en `/splash` para verificar si hay sesión activa
  initialLocation: '/splash',

  routes: [

    //  Rutas de autenticación
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),

    // ---  Shell principal (con BottomNavigationBar) ---
    ShellRoute(
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          path: '/main_home',
          builder: (context, state) => const MainHomeScreen(),
        ),
        GoRoute(
          path: '/projects',
          builder: (context, state) => const ProjectScreen(),
        ),
        GoRoute(
          path: '/users',
          builder: (context, state) => const UsersScreen(),
        ),
        GoRoute(
          path: '/news',
          builder: (context, state) => const NewsScreen(),
        ),
        GoRoute(
          path: '/inventory',
          builder: (context, state) => const InventoryScreen(),
        ),
      ],
    ),

    // Rutas independientes
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
