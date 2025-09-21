import 'package:flutter/material.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final String projectName = "Diseño de Prototipo de Robot";
    final String date = "21 de septiembre de 2025";
    final String description = "Solicitud para el uso de equipos de impresión 3D y láser para la creación del prototipo de robot. Se requiere acceso al software de diseño para la fase de modelado.";

    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, 
              children: [
                // Nombre del proyecto
                Text(
                  projectName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),
                const SizedBox(height: 8),

                // Fecha
                Text(
                  "Fecha: $date",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                // Descripción
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 24),

                // Botones de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                    
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Solicitud Aprobada')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, 
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Aprobar'),
                    ),
                    ElevatedButton(
                      onPressed: () {
               
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Solicitud Rechazada')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, 
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Rechazar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}