import 'package:flutter/material.dart';

class ProyectosViews extends StatelessWidget {
  const ProyectosViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Proyectos'),
          FilledButton.tonal(
            onPressed:(){
            }, 
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}