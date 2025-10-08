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

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  
  final List<Project> _projects = [
    Project(
      imageUrl: 'https://picsum.photos/300/200?random=1',
      name: 'Sistema de Gestión',
      status: 'En Progreso',
      participants: '5 participantes',
    ),
    Project(
      imageUrl: 'https://picsum.photos/300/200?random=2',
      name: 'App de Inventario',
      status: 'Finalizado',
      participants: '3 participantes',
    ),
    Project(
      imageUrl: 'https://picsum.photos/300/200?random=3',
      name: 'Página Web Clientes',
      status: 'Pendiente',
      participants: '8 participantes',
    ),
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

  
    final filteredProjects = _projects
        .where((project) =>
            project.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            project.status.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            project.participants.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
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
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          
          // List of filtered projects
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: filteredProjects.length, // Use the filtered list count
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final project = filteredProjects[index]; // Use the filtered list
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