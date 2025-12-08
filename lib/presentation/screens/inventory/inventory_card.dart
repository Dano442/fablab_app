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

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        debugPrint("Ver detalles de ${tool.name}");
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  tool.imageUrl,
                  width: 65,
                  height: 65,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 65,
                    height: 65,
                    color: colors.surfaceContainerHighest,
                    child: Icon(
                      Icons.construction,
                      color: colors.primary,
                      size: 32,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

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

                    Text(
                      "Código: ${tool.code}",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    Text(
                      "Cantidad: ${tool.quantity}",
                      style: textTheme.bodyMedium?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: tool.available
                            ? colors.secondaryContainer
                            : colors.errorContainer,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        tool.available ? "Disponible" : "No disponible",
                        style: textTheme.bodySmall?.copyWith(
                          color: tool.available
                              ? colors.onSecondaryContainer
                              : colors.onErrorContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: colors.primary),
                    onPressed: () {
                      debugPrint("Editar herramienta: ${tool.name}");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: colors.error),
                    onPressed: () {
                      debugPrint("Eliminar herramienta: ${tool.name}");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
