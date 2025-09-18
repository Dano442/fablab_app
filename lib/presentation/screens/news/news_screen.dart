import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: Text(
          'Noticias',
          style: textTheme.titleLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Placeholder(),
    );
  }
}