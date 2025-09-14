import 'package:fablab_app/presentation/screens/inventario/inventario_screen.dart';
import 'package:fablab_app/presentation/screens/inicio/inicio_screen.dart';
import 'package:fablab_app/presentation/screens/noticias/noticias_screen.dart';
import 'package:fablab_app/presentation/screens/proyectos/proyectos_screen.dart';
import 'package:fablab_app/presentation/screens/usuarios/usuarios_screen.dart';
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
    InicioScreen(),
    ProyectosScreen(),  
    UsuariosScreen(),
    NoticiasScreen(),
    InventarioScreen(),
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

