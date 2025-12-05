import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const UserCard({
    super.key,
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundImage:
                      (user.imgUrl != null && user.imgUrl!.isNotEmpty)
                          ? NetworkImage(user.imgUrl!)
                          : const NetworkImage(
                            'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                          ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.nombreCompleto,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('RUT: ${user.rut}'),
                      Text('Correo: ${user.correoInstitucional}'),
                      Text('Teléfono: ${user.telefono}'),
                      Text('Carrera: ${user.carrera}'),
                      Text('Rol: ${user.tipoRol}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  label: const Text('Editar'),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: const Text('Eliminar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
