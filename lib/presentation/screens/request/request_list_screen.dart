import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestListScreen extends StatefulWidget {
  const RequestListScreen({super.key});

  @override
  State<RequestListScreen> createState() => _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  final List<Map<String, dynamic>> _requests = [
    {
      'id': 1,
      'project': 'Diseño de Prototipo de Robot',
      'date': '21 de septiembre de 2025',
      'status': 'Pendiente',
      'description':
          'Solicitud para el uso de equipos de impresión 3D y láser para la creación del prototipo de robot.',
    },
    {
      'id': 2,
      'project': 'Estructura 3D para maqueta de arquitectura',
      'date': '19 de septiembre de 2025',
      'status': 'Aprobada',
      'description':
          'Uso de impresoras 3D para crear modelos de edificios a escala.',
    },
    {
      'id': 3,
      'project': 'Corte de piezas para dron FPV',
      'date': '17 de septiembre de 2025',
      'status': 'Rechazada',
      'description':
          'Uso de cortadora láser para piezas acrílicas del dron experimental.',
    },
  ];

  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final filtered = _requests
        .where((r) =>
            r['project'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
            r['status'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes'),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar solicitud...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final req = filtered[index];
                final Color statusColor = req['status'] == 'Aprobada'
                    ? Colors.green
                    : req['status'] == 'Pendiente'
                        ? Colors.orange
                        : Colors.red;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.description, color: colors.primary),
                    title: Text(req['project'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Fecha: ${req['date']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        req['status'],
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onTap: () => context.push('/request/${req['id']}', extra: req),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primary,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Funcionalidad de nueva solicitud próximamente'),
          ));
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
