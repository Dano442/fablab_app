import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';
import 'package:fablab_app/presentation/screens/users/user_card.dart';
import 'package:fablab_app/presentation/screens/users/user_form.dart';
import 'package:fablab_app/data/services/user_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final UserService _userService = UserService();

  List<UserModel> users = [];
  String _searchQuery = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _loading = true);
    final fetchedUsers = await _userService.getAllUsers();
    setState(() {
      users = fetchedUsers;
      _loading = false;
    });
  }

  Future<void> _addUser(UserModel user) async {
    final success = await _userService.addUser(user);
    if (success) {
      _loadUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Usuario agregado exitosamente')),
      );
    }
  }

  Future<void> _editUser(UserModel updatedUser) async {
    final success = await _userService.updateUser(updatedUser);
    if (success) {
      _loadUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Usuario actualizado')),
      );
    }
  }

  Future<void> _deleteUser(UserModel user) async {
    final success = await _userService.deleteUser(user.id.toString());
    if (success) {
      _loadUsers();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🗑️ Usuario eliminado')),
      );
    }
  }

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

    final filteredUsers = users.where((user) {
      final query = _searchQuery.toLowerCase();
      return user.nombre.toLowerCase().contains(query) ||
          user.apellido.toLowerCase().contains(query) ||
          user.correoInstitucional.toLowerCase().contains(query) ||
          user.rut.toLowerCase().contains(query) ||
          user.carrera.toLowerCase().contains(query) ||
          user.tipoRol.toLowerCase().contains(query);
    }).toList();

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
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(height: 10),

          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filteredUsers.isEmpty
                    ? const Center(child: Text('No hay usuarios registrados'))
                    : RefreshIndicator(
                        onRefresh: _loadUsers,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: filteredUsers.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
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
          ),
        ],
      ),
    );
  }
}
