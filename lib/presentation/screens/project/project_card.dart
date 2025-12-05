import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/project_model.dart';

class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  double _scale = 1.0;
  double _elevation = 4.0;

  void _onTapDown(TapDownDetails _) {
    setState(() {
      _scale = 0.97;
      _elevation = 8.0;
    });
  }

  void _onTapUp(TapUpDetails _) {
    setState(() {
      _scale = 1.0;
      _elevation = 4.0;
    });
  }

  void _onTapCancel() {
    setState(() {
      _scale = 1.0;
      _elevation = 4.0;
    });
  }

  String _getParticipants() {
    if (widget.project.usuarios.isEmpty) return "Sin participantes";

    return widget.project.usuarios
        .map((u) => "${u.nombre} ${u.apellido}")
        .join(", ");
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final participants = _getParticipants();

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeOut,
          child: Card(
            color: colors.surface,
            surfaceTintColor: colors.surfaceTint,
            elevation: _elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image:
                            project.imgUrl?.isNotEmpty == true
                                ? project.imgUrl!
                                : "https://via.placeholder.com/400x300?text=Sin+Imagen",
                        fit: BoxFit.cover,
                        imageErrorBuilder:
                            (_, _, _) => Center(
                              child: Icon(
                                Icons.broken_image,
                                size: 50,
                                color: colors.error,
                              ),
                            ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            project.titulo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.onSurface,
                            ),
                          ),

                          if (project.categoria != null &&
                              project.categoria!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "Categoría: ${project.categoria!}",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),

                          if (project.areaAplicacion != null &&
                              project.areaAplicacion!.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                "Área: ${project.areaAplicacion!}",
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 20,
                                color: colors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  participants,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colors.onSurface,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// MENU DE OPCIONES
                Positioned(
                  top: 8,
                  right: 8,
                  child: Material(
                    color: colors.surface,
                    elevation: 3,
                    shape: const CircleBorder(),
                    child: PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: colors.onSurface),
                      onSelected: (value) {
                        if (value == 'edit' && widget.onEdit != null) {
                          widget.onEdit!();
                        } else if (value == 'delete' &&
                            widget.onDelete != null) {
                          widget.onDelete!();
                        }
                      },
                      itemBuilder:
                          (context) => [
                            PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: colors.primary),
                                  const SizedBox(width: 8),
                                  const Text('Editar'),
                                ],
                              ),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: colors.error),
                                  const SizedBox(width: 8),
                                  const Text('Eliminar'),
                                ],
                              ),
                            ),
                          ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
