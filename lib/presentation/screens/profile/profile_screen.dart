// Archivo: profile_screen.dart
import 'package:fablab_app/presentation/screens/profile/profile_details_screen';
import 'package:fablab_app/presentation/screens/profile/profile_themes_screen.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
 const ProfileScreen({super.key});

 @override
 Widget build(BuildContext context) {
  return Scaffold(
   appBar: AppBar(
    title: const Text('Configuraciones'),
    backgroundColor: Theme.of(context).colorScheme.primary,
    foregroundColor: Theme.of(context).colorScheme.onPrimary,
   ),
   body: ListView(
    children: [
     // Opción de Perfil
     ListTile(
      leading: const Icon(Icons.person),
      title: const Text('Perfil'),
      subtitle: const Text('Edita tu información personal'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
       Navigator.push(
        context,
        MaterialPageRoute(
         builder: (context) => const ProfileDetailsScreen(),
        ),
       );
      },
     ),
     const Divider(),

     ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Temas'),
      subtitle: const Text('Ajusta el tema que más te guste'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
       Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileThemesScreen()),
       );
      },
     ),
     const Divider(),
     
     // Opción de Cerrar Sesión
     ListTile(
      leading: const Icon(Icons.logout),
      title: const Text('Cerrar sesión'),
      subtitle: const Text('Sal de tu cuenta'),
      onTap: () {
       // Lógica para cerrar la sesión
      },
     ),
    ],
   ),
  );
 }
}