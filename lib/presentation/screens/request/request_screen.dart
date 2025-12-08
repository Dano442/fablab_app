import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fablab_app/data/services/request_service.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String _searchQuery = "";
  String filterStatus = "Todos";

  final RequestService _service = RequestService();
  List<dynamic> _requests = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    try {
      final data = await _service.getRequests();

      setState(() {
        _requests = data; 
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  Future<void> _approve(int id, String title) async {
    final ok = await _service.approveRequest(id);

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("✅ $title aprobado")),
      );
      _loadRequests();
    }
  }

  Future<void> _reject(int id, String title) async {
    final ok = await _service.rejectRequest(id);

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ $title rechazado")),
      );
      _loadRequests();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filtered = _requests.where((r) {
      final title = r["nombre"] ?? "";
      final desc = r["carrera"] ?? "";

      final matchesSearch = title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                            desc.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus = filterStatus == "Todos"; 

      return matchesSearch && matchesStatus;
    }).toList();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result){
        if (!didPop) context.go('/main_home');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          elevation: 2,
          centerTitle: true,
          title: Text(
            'Solicitudes (${filtered.length})',
            style: textTheme.titleLarge?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colors.onPrimary),
            onPressed: () => context.go('/main_home'),
          ),
        ),

        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
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
                      ],
                    ),
                    const SizedBox(height: 12),

                    // LISTA
                    Expanded(
                      child: filtered.isEmpty
                          ? Center(
                              child: Text(
                                'No se encontraron solicitudes',
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: filtered.length,
                              itemBuilder: (context, index) {
                                final req = filtered[index];

                                final id = req["id"];
                                final title = req["nombre"] ?? "Sin nombre";
                                final desc = req["carrera"] ?? "Sin carrera";

                                return Card(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          title,
                                          style: textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(desc),
                                        const SizedBox(height: 8),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () => _approve(id, title),
                                              icon: const Icon(Icons.check_circle,
                                                  color: Colors.green),
                                            ),
                                            IconButton(
                                              onPressed: () => _reject(id, title),
                                              icon: const Icon(Icons.cancel,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        )
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
      ),
    );
  }
}
