import 'package:flutter/material.dart';

class NoticiasViews extends StatelessWidget {
  const NoticiasViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('oaaa'),
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