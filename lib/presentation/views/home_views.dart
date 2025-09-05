import 'package:flutter/material.dart';

class HomeViews extends StatelessWidget {
  const HomeViews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text('oa'),
            FilledButton.tonal(
              onPressed:(){
              }, 
              child: const Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}