import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String imageUrl;
  final String projectName;
  final String projectStatus;
  final String participants;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.imageUrl,
    required this.projectName,
    required this.projectStatus,
    required this.participants,
    this.onTap,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  double _scale = 1.0;
  double _elevation = 4.0;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _scale = 0.97;
      _elevation = 8.0; // aumenta sombra al presionar
    });
  }

  void _onTapUp(TapUpDetails details) {
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

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

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
            shadowColor: colors.shadow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: _elevation,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen con placeholder y fallback
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/placeholder.png',
                    image: widget.imageUrl,
                    fit: BoxFit.cover,
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Center(
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
                      // Nombre del proyecto
                      Text(
                        widget.projectName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colors.onSurface,
                            ),
                      ),
                      const SizedBox(height: 4),
                      // Estado del proyecto
                      Text(
                        "Estado: ${widget.projectStatus}",
                        style: textTheme.bodyMedium?.copyWith(
                              color: colors.onSurfaceVariant,
                            ),
                      ),
                      const SizedBox(height: 8),
                      // Participantes
                      Row(
                        children: [
                          Icon(Icons.people,
                              size: 20, color: colors.onSurfaceVariant),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.participants,
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
          ),
        ),
      ),
    );
  }
}
