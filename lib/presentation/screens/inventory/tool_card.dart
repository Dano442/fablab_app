import 'package:flutter/material.dart';

class Tool {
  final String name;
  final String code;
  final String imageUrl;
  final int quantity;
  final bool available;

  Tool({
    required this.name,
    required this.code,
    required this.imageUrl,
    required this.quantity,
    required this.available,
  });
}

class ToolCard extends StatelessWidget {
  final Tool tool;

  const ToolCard({super.key, required this.tool});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen segura (usa Image.network en vez de FadeInImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                tool.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: colors.surfaceVariant,
                    child: const Icon(Icons.broken_image, size: 28),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),

            // Información
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tool.name,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.onSurface,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('Código: ${tool.code}', style: textTheme.bodyMedium),
                  Text('Cantidad: ${tool.quantity}', style: textTheme.bodyMedium),
                  Text(
                    tool.available ? 'Disponible' : 'No disponible',
                    style: textTheme.bodyMedium?.copyWith(
                      color: tool.available ? colors.primary : colors.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Acciones
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: colors.primary),
                  onPressed: () {
                    debugPrint('Editar herramienta: ${tool.name}');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: colors.error),
                  onPressed: () {
                    debugPrint('Eliminar herramienta: ${tool.name}');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
