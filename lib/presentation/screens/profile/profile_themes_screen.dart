import 'package:flutter/material.dart';
import 'package:fablab_app/config/theme/app_theme.dart';
import 'package:fablab_app/main.dart';

class ProfileThemesScreen extends StatelessWidget {
  const ProfileThemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final themeState = MainApp.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Temas'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Modo oscuro"),
              value: themeState.isDarkMode,
              onChanged: (value) {
                themeState.setDarkMode(value);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      value ? "Modo oscuro activado" : "Modo claro activado",
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

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
                    themeState.setTheme(index);
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
