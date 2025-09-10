import 'package:flutter/material.dart';

class CustomBottomNavegation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavegation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTabSelected,
      elevation: 0,
      // type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: "Inicio",
          backgroundColor: colors.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.amp_stories_rounded),
          label: "Proyectos",
          backgroundColor: colors.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.settings),
          label: "Gestión",
          backgroundColor: colors.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.group),
          label: "Usuarios",
          backgroundColor: colors.primary,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.receipt),
          label: "Noticias",
          backgroundColor: colors.primary,
        ),
      ],
    );
  }
}
