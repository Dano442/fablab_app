import 'package:fablab_app/domain/models/project_model.dart';

class ProjectService {
  final List<ProjectModel> _projects = [
    ProjectModel(
      id: '1',
      name: 'Diseño de Prototipo de Robot',
      description:
          'Proyecto enfocado en la creación de un prototipo funcional de robot con sensores y movimiento automatizado.',
      owner: 'Daniel Ronceros',
      status: 'En progreso',
      date: 'Octubre 2025',
    ),
    ProjectModel(
      id: '2',
      name: 'Sistema de Inventario Inteligente',
      description:
          'Desarrollo de una aplicación móvil y web para la gestión automatizada de inventario en el FabLab.',
      owner: 'Alexis Pérez',
      status: 'Completado',
      date: 'Septiembre 2025',
    ),
    ProjectModel(
      id: '3',
      name: 'Impresión 3D Sostenible',
      description:
          'Investigación y uso de materiales reciclables en procesos de impresión 3D para reducir el impacto ambiental.',
      owner: 'María José Gutiérrez',
      status: 'Planificado',
      date: 'Noviembre 2025',
    ),
  ];

  List<ProjectModel> getAllProjects() => _projects;

  void addProject(ProjectModel project) {
    _projects.add(project);
  }

  void updateProject(ProjectModel updated) {
    final index = _projects.indexWhere((p) => p.id == updated.id);
    if (index != -1) _projects[index] = updated;
  }

  void deleteProject(String id) {
    _projects.removeWhere((p) => p.id == id);
  }
}
