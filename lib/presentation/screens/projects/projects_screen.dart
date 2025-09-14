import 'package:fablab_app/presentation/views/cards.dart';
import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Proyectos'),
        
      ),
      body: CardsViews(), 
    );
  }
}