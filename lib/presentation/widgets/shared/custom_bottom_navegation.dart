// import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomBottomNavegation extends StatefulWidget {
  const CustomBottomNavegation({super.key});

  @override
  State<CustomBottomNavegation> createState() => _CustomBottomNavegationState();
}

class _CustomBottomNavegationState extends State<CustomBottomNavegation> {
    int selectedIndex = 0;


  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
      elevation: 0,
      // type: BottomNavigationBarType.fixed,
      // backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      // unselectedItemColor: Colors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: "Inicio", backgroundColor: colors.primary),
        BottomNavigationBarItem(icon: Icon(Icons.amp_stories_rounded), label: "Proyectos", backgroundColor: colors.primary),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Gestión", backgroundColor: colors.primary),
        BottomNavigationBarItem(icon: Icon(Icons.group), label: "Usuarios", backgroundColor: colors.primary),
        BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Noticias", backgroundColor: colors.primary),        
      ]);
  }
}