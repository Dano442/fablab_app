import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';
import 'package:fablab_app/data/services/user_service.dart';
import 'package:fablab_app/presentation/screens/users/user_card.dart';
import 'package:fablab_app/presentation/screens/users/user_form.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserService _userService = UserService();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    //  Filtrar usuarios
    final filteredUsers = _userService
        .getAllUsers()
        .where((user) =>
            user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.rut.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.career.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.project.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        backgroundColor: colors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 12),
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
          const SizedBox(height: 8),
          Expanded(
            child: filteredUsers.isEmpty
                ? const Center(child: Text('No hay usuarios disponibles'))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredUsers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return UserCard(
                        user: user,
                        onEdit: () => _editUser(user),
                        onDelete: () => _deleteUser(user.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  //  Crear usuario nuevo
  void _addUser() {
    showDialog(
      context: context,
      builder: (_) => UserForm(
        onSubmit: (newUser) {
          setState(() => _userService.addUser(newUser));
        },
      ),
    );
  }

  //  Editar usuario
  void _editUser(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => UserForm(
        user: user,
        onSubmit: (updatedUser) {
          setState(() => _userService.updateUser(updatedUser));
        },
      ),
    );
  }

  //  Eliminar usuario
  void _deleteUser(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text('¿Deseas eliminar este usuario?'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              setState(() => _userService.deleteUser(id));
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
