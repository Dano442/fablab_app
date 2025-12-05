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

  List<ProjectModel> _projects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    setState(() => _loading = true);

    final projects = await _service.getAllProjects();
    if (!mounted) return;

    setState(() {
      _projects = projects;
      _loading = false;
    });
  }

  Future<void> _addProject(ProjectModel project) async {
    final ok = await _service.createProject(project);
    if (!mounted) return;

    if (ok) {
      await _loadProjects();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proyecto creado correctamente')),
      );
    }
  }

  Future<void> _editProject(ProjectModel project) async {
    final ok = await _service.updateProject(project);
    if (!mounted) return;

    if (ok) {
      await _loadProjects();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Proyecto actualizado')),
      );
    }
  }

  Future<void> _deleteProject(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar Proyecto'),
        content: const Text('¿Deseas eliminar este proyecto?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final ok = await _service.deleteProject(id);
      if (!mounted) return;

      if (ok) {
        await _loadProjects();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Proyecto eliminado')),
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

    final filteredProjects = _projects.where((p) {
      final q = _searchQuery.toLowerCase();
      return p.titulo.toLowerCase().contains(q) ||
          (p.categoria?.toLowerCase().contains(q) ?? false) ||
          (p.descripcionProyecto?.toLowerCase().contains(q) ?? false);
    }).toList();

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
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filteredProjects.isEmpty
                    ? const Center(child: Text('No hay proyectos registrados'))
                    : RefreshIndicator(
                        onRefresh: _loadProjects,
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
                          itemCount: filteredProjects.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final project = filteredProjects[index];

                            return ProjectCard(
                              project: project,
                              onTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(project.titulo),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(project.descripcionProyecto ??
                                            "Sin descripción"),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Fecha inicio: ${project.fechaInicio != null ? project.fechaInicio!.toString().split('T')[0] : 'N/A'}",
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dialogContext).pop(),
                                        child: const Text('Cerrar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onEdit: () => _openForm(project: project),
                              onDelete: () => _deleteProject(project.id),
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
