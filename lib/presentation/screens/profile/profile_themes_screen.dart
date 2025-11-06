// lib/presentation/screens/profile/profile_themes_screen.dart

import 'package:flutter/material.dart';
import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:fablab_app/main.dart'; // acceder a MainApp.of(context)

class ProfileThemesScreen extends StatelessWidget {
  const ProfileThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onPrimary),
          onPressed: () => Navigator.pop(context), // 🔙 volver atrás
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Selecciona un color para el tema:',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(colorList.length, (index) {
                final color = colorList[index];
                return GestureDetector(
                  onTap: () {
                    MainApp.of(context).setTheme(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tema cambiado correctamente'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black54,
                        width: 1.5,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
