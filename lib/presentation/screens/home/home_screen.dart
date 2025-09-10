import 'package:fablab_app/config/menu/menu_items.dart';
import 'package:fablab_app/presentation/views/gestion_views.dart';
import 'package:fablab_app/presentation/views/noticias_views.dart';
// import 'package:fablab_app/presentation/views/home_views.dart';
import 'package:fablab_app/presentation/views/proyectos_views.dart';
import 'package:fablab_app/presentation/views/usuarios_views.dart';
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
    _HomeView(),
    ProyectosViews(),
    GestionViews(),
    UsuariosViews(),
    NoticiasViews()
    ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido al Panel Administrativo'),
      ),
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

// 👇 Vista principal con el listado de items
class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: appMenuItems.length,
      itemBuilder: (context, index) {
        final menuItem = appMenuItems[index];
        return _CustomListTile(menuItem: menuItem);
      },
    );
  }
}

class _CustomListTile extends StatelessWidget {
  const _CustomListTile({required this.menuItem});

  final MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(menuItem.icon, color: colors.primary),
      trailing: Icon(Icons.arrow_forward_ios_rounded, color: colors.primary),
      title: Text(menuItem.title),
      subtitle: Text(menuItem.subTitle),

    );
  }
}