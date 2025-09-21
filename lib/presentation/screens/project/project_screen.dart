import 'package:fablab_app/presentation/screens/project/project_card.dart';
import 'package:flutter/material.dart';

class Project {
  final String imageUrl;
  final String name;
  final String status;
  final String participants;

  Project({
    required this.imageUrl,
    required this.name,
    required this.participants,
    required this.status,
  });
}

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final List<Project> projects = [
      Project(
        imageUrl: 'https://picsum.photos/300/200',
        name: 'Sistema de Gestión',
        status: 'En Progreso',
        participants: '5 participantes',
      ),
      Project(
        imageUrl: 'https://picsum.photos/300/200',
        name: 'App de Inventario',
        status: 'Finalizado',
        participants: '3 participantes',
      ),
      Project(
        imageUrl: 'https://picsum.photos/300/200',
        name: 'Página Web Clientes',
        status: 'Pendiente',
        participants: '8 participantes',
      ),
    ];

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              'Lista de Proyectos',
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ),
          

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: projects.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final project = projects[index];
                return ProjectCard(
                  imageUrl: project.imageUrl,
                  projectName: project.name,
                  projectStatus: project.status,
                  participants: project.participants,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}