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
        children: const [
          // Sección de cuenta
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Perfil'),
            subtitle: Text('Edita tu información personal'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),

          // Sección de notificaciones
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notificaciones'),
            subtitle: Text('Ajusta tus preferencias de notificaciones'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),

          // Sección de privacidad
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacidad'),
            subtitle: Text('Configura la privacidad de tu cuenta'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),

          // Sección de ayuda
          ListTile(
            leading: Icon(Icons.help_outline),
            title: Text('Ayuda y Soporte'),
            subtitle: Text('Preguntas frecuentes, contacto, etc.'),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          Divider(),

          // Sección de cerrar sesión
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar sesión'),
            subtitle: Text('Sal de tu cuenta'),
            // No tiene trailing icon porque es una acción directa
          ),
        ],
      ),
    );
  }
}