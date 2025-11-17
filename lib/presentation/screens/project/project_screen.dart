import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/project_model.dart';
import 'package:fablab_app/presentation/screens/project/project_form.dart';
import 'package:fablab_app/presentation/screens/project/project_card.dart';
import 'package:fablab_app/data/services/project_service.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  final ProjectService _service = ProjectService();
  String _searchQuery = "";

  
  void _addProject(ProjectModel project) {
    if (!mounted) return;
    setState(() => _service.addProject(project));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proyecto agregado')),
    );
  }


  void _editProject(ProjectModel project) {
    if (!mounted) return;
    setState(() => _service.updateProject(project));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Proyecto actualizado')),
    );
  }

  Future<void> _deleteProject(String id) async {
    if (!mounted) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar Proyecto'),
        content: const Text(
          '¿Estás seguro de que deseas eliminar este proyecto?',
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
    );

    if (confirmed == true && mounted) {
      setState(() => _service.deleteProject(id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proyecto eliminado correctamente')),
        );
      }
    }
  }

  void _openForm({ProjectModel? project}) {
    showDialog(
      context: context,
      builder: (_) => ProjectForm(
        project: project,
        onSubmit: project == null ? _addProject : _editProject,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final filteredProjects = _service
        .getAllProjects()
        .where((p) =>
            p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            p.owner.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        label: const Text('Nuevo Proyecto'),
        icon: const Icon(Icons.add),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar proyecto...",
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
          const SizedBox(height: 12),
          Expanded(
            child: filteredProjects.isEmpty
                ? const Center(child: Text('No hay proyectos registrados'))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredProjects.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final project = filteredProjects[index];
                      return Stack(
                        children: [
                          // 
                          ProjectCard(
                            imageUrl: 'https://picsum.photos/400?random=$index',
                            projectName: project.name,
                            projectStatus: project.status,
                            participants: 'Responsable: ${project.owner}',
                            onTap: () async {
                              if (!mounted) return;
                              await showDialog(
                                context: context,
                                builder: (dialogContext) => AlertDialog(
                                  title: Text(project.name),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(project.description),
                                      const SizedBox(height: 12),
                                      Text(
                                          "Estado: ${project.status} | Fecha: ${project.date}"),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(dialogContext).pop();
                                      },
                                      child: const Text('Cerrar'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),

                          // 
                          Positioned(
                            top: 12,
                            right: 12,
                            child: PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert),
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _openForm(project: project);
                                } else if (value == 'delete') {
                                  _deleteProject(project.id);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, color: Colors.blue),
                                      SizedBox(width: 8),
                                      Text('Editar'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('Eliminar'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
