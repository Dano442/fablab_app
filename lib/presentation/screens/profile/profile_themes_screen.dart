// Archivo: profile_themes.dart
import 'package:flutter/material.dart';
import 'package:fablab_app/main.dart';
import 'package:fablab_app/config/theme/app_theme.dart'; 

class ProfileThemesScreen extends StatelessWidget {
  const ProfileThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        children: [
          _buildColorSelectionSection(context),
        ],
      ),
    );
  }

  Widget _buildColorSelectionSection(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona un color para el tema',
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colors.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 10,
            children: colorList.asMap().entries.map((entry) {
              final int index = entry.key;
              final Color color = entry.value;
              return GestureDetector(
                onTap: () {
                  
                  MainApp.of(context).setTheme(index);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.5,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}