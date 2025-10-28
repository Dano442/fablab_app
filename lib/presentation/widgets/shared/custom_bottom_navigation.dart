import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavigation({
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
      type: BottomNavigationBarType.fixed,


      selectedItemColor: Colors.black,
      unselectedItemColor: colors.onPrimary.withOpacity(0.7),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      backgroundColor: colors.primary,


      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Inicio",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.amp_stories_rounded),
          label: "Proyectos",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: "Usuarios",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: "Noticias",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.inventory_outlined),
          label: "Inventario",
        ),
      ],
    );
  }
}
