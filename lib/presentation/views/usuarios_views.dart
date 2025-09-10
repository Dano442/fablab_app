import 'package:flutter/material.dart';

class UsuariosViews extends StatelessWidget {
  const UsuariosViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Usuarios'),
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