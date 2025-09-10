import 'package:flutter/material.dart';

class GestionViews extends StatelessWidget {
  const GestionViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Gestion'),
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