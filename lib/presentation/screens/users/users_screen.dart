import 'package:flutter/material.dart';
import 'package:fablab_app/presentation/screens/users/user_card.dart';

class User {
  final String imageUrl;
  final String name;
  final String rut;
  final String career;
  final String role;
  final String project;

  User({
    required this.imageUrl,
    required this.name,
    required this.rut,
    required this.career,
    required this.role,
    required this.project,
  });
}

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<User> users = [
      User(
        imageUrl: 'https://picsum.photos/200?random=1',
        name: 'Daniel Ronceros',
        rut: '12.345.678-9',
        career: 'Ing. Civil Industrial',
        role: 'Administrador',
        project: 'App de Inventario',
      ),
      User(
        imageUrl: 'https://picsum.photos/200?random=2',
        name: 'Alexis Pérez',
        rut: '13.456.789-0',
        career: 'Diseño Gráfico',
        role: 'Administrador',
        project: 'Página Web Clientes',
      ),
      User(
        imageUrl: 'https://picsum.photos/200?random=3',
        name: 'María Jose Gutiérrez',
        rut: '14.567.890-1',
        career: 'Ing. en Informática',
        role: 'Usuario',
        project: 'Sistema de Gestión',
      ),
    ];

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text(
          'Usuarios',
          style: textTheme.titleLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        separatorBuilder: (_, __) => Divider(
          thickness: 1,
          height: 16,
          color: colors.outlineVariant.withValues(),
        ),
        itemBuilder: (context, index) {
          final user = users[index];
          return UserCard(
            user: user,
            onEdit: () {
              debugPrint('Editar usuario: ${user.name}');
            },
            onDelete: () {
              debugPrint('Eliminar usuario: ${user.name}');
            },
          );
        },
      ),
    );
  }
}
