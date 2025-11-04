import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';
import 'package:fablab_app/presentation/screens/users/user_card.dart';
import 'package:fablab_app/presentation/screens/users/user_form.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<UserModel> users = [
    UserModel(
      id: '1',
      name: 'Daniel Ronceros',
      email: 'daniel@fablab.cl',
      rut: '12.345.678-9',
      career: 'Ing. Civil Industrial',
      role: 'Administrador',
      project: 'App de Inventario',
      imageUrl: 'https://picsum.photos/200?random=1',
    ),
    UserModel(
      id: '2',
      name: 'Alexis Pérez',
      email: 'alexis@fablab.cl',
      rut: '13.456.789-0',
      career: 'Diseño Gráfico',
      role: 'Administrador',
      project: 'Página Web Clientes',
      imageUrl: 'https://picsum.photos/200?random=2',
    ),
  ];

  String _searchQuery = "";

  // --- Crear usuario ---
  void _addUser(UserModel user) {
    setState(() {
      users.add(user);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario agregado exitosamente')),
    );
  }

  // --- Editar usuario ---
  void _editUser(UserModel updatedUser) {
    setState(() {
      final index = users.indexWhere((u) => u.id == updatedUser.id);
      if (index != -1) users[index] = updatedUser;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario actualizado')),
    );
  }

  // --- Eliminar usuario ---
  void _deleteUser(UserModel user) {
    setState(() {
      users.removeWhere((u) => u.id == user.id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario eliminado')),
    );
  }

  // --- Mostrar formulario (crear o editar) ---
  void _openUserForm({UserModel? user}) {
    showDialog(
      context: context,
      builder: (_) => UserForm(
        user: user,
        onSubmit: user == null ? _addUser : _editUser,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final filteredUsers = users
        .where((user) =>
            user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.rut.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.career.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.project.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openUserForm(),
        label: const Text('Agregar Usuario'),
        icon: const Icon(Icons.add),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar usuario...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: filteredUsers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return UserCard(
                  user: user,
                  onEdit: () => _openUserForm(user: user),
                  onDelete: () => _deleteUser(user),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
