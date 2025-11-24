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
    final data = await _userService.getAllUsers();
    setState(() {
      users = data;
      _loading = false;
    });
  }

  Future<void> _addUser(UserModel user) async {
    final ok = await _userService.addUser(user);
    if (ok) {
      await _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Usuario agregado")));
      }
    }
  }

  Future<void> _editUser(UserModel user) async {
    final ok = await _userService.updateUser(user);
    if (ok) {
      await _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Usuario actualizado")));
      }
    }
  }

  Future<bool> _confirmDelete(UserModel user) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: const Text('Eliminar Usuario'),
            content: Text(
              '¿Estás seguro de que deseas eliminar a "${user.nombre} ${user.apellido}"? Esta acción no se puede deshacer.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text(
                  'Eliminar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
  Future<void> _deleteUser(UserModel user) async {
    if (user.id == null) return;

    final confirm = await _confirmDelete(user);
    if (!confirm) return;

    final ok = await _userService.deleteUser(user.id!);
    if (ok) {
      await _loadUsers();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Usuario eliminado")));
      }
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

    final filtered = users.where((u) {
      final q = _searchQuery.toLowerCase();
      return u.nombre.toLowerCase().contains(q) ||
          u.apellido.toLowerCase().contains(q) ||
          u.correoInstitucional.toLowerCase().contains(q) ||
          u.rut.toLowerCase().contains(q) ||
          u.carrera.toLowerCase().contains(q) ||
          u.tipoRol.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
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
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text("No hay usuarios registrados"))
                    : RefreshIndicator(
                        onRefresh: _loadUsers,
                        child: ListView.separated(
                          padding: const EdgeInsets.all(12),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (_, index) {
                            final user = filtered[index];
                            return UserCard(
                              user: user,
                              onEdit: () => _openUserForm(user: user),
                              onDelete: () => _deleteUser(user), // ← listo
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
