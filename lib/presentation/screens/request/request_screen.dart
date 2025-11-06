import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String _searchQuery = "";
  String _filterStatus = "Todos";

  final List<Map<String, String>> _requests = [
    {
      'title': 'Prototipo de Robot',
      'date': '21 de septiembre de 2025',
      'description':
          'Uso de impresoras 3D y cortadora láser para el desarrollo del prototipo.',
      'status': 'Pendiente',
    },
    {
      'title': 'Proyecto de Dron',
      'date': '15 de octubre de 2025',
      'description': 'Solicitud para calibrar sensores y probar motores.',
      'status': 'Aprobado',
    },
    {
      'title': 'Diseño Web FabLab',
      'date': '2 de noviembre de 2025',
      'description': 'Uso de laboratorio de diseño y acceso a software gráfico.',
      'status': 'Rechazado',
    },
    {
      'title': 'Actualización de Equipos CNC',
      'date': '1 de noviembre de 2025',
      'description': 'Solicitud para mantenimiento y calibración de equipos CNC.',
      'status': 'Pendiente',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 🔍 Filtro combinado
    final filteredRequests = _requests.where((r) {
      final matchesSearch = r['title']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          r['description']!
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());
      final matchesStatus =
          _filterStatus == "Todos" || r['status'] == _filterStatus;
      return matchesSearch && matchesStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Solicitudes (${filteredRequests.length})',
          style: textTheme.titleLarge?.copyWith(
            color: colors.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.onPrimary),
          tooltip: 'Volver al Home',
          onPressed: () => context.go('/main_home'),
        ),
      ),
      backgroundColor: colors.surface,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Barra de búsqueda y filtro
            Row(
              children: [
                Expanded(
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
                    onChanged: (value) =>
                        setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _filterStatus,
                  items: const [
                    DropdownMenuItem(
                        value: 'Todos', child: Text('Todos')),
                    DropdownMenuItem(
                        value: 'Pendiente', child: Text('Pendientes')),
                    DropdownMenuItem(
                        value: 'Aprobado', child: Text('Aprobadas')),
                    DropdownMenuItem(
                        value: 'Rechazado', child: Text('Rechazadas')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _filterStatus = value);
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // 🔹 Lista de solicitudes
            Expanded(
              child: filteredRequests.isEmpty
                  ? Center(
                      child: Text(
                        'No se encontraron solicitudes',
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredRequests.length,
                      itemBuilder: (context, index) {
                        final request = filteredRequests[index];
                        final status = request['status']!;

                        Color statusColor;
                        switch (status) {
                          case 'Aprobado':
                            statusColor = Colors.green;
                            break;
                          case 'Rechazado':
                            statusColor = Colors.red;
                            break;
                          default:
                            statusColor = Colors.orange;
                        }

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🟦 Encabezado
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        request['title']!,
                                        style: textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colors.onSurface,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: statusColor, width: 1),
                                      ),
                                      child: Text(
                                        status,
                                        style: TextStyle(
                                          color: statusColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "Fecha: ${request['date']}",
                                  style: textTheme.bodySmall?.copyWith(
                                    color: Colors.grey[700],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  request['description']!,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              '✅ ${request['title']} aprobada'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      },
                                      icon: const Icon(Icons.check_circle,
                                          color: Colors.green),
                                      tooltip: 'Aprobar',
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              '❌ ${request['title']} rechazada'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                      },
                                      icon: const Icon(Icons.cancel,
                                          color: Colors.red),
                                      tooltip: 'Rechazar',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
