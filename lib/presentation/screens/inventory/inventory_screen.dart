import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/inventory_model.dart';
import 'package:fablab_app/data/services/inventory_service.dart';
import 'package:fablab_app/presentation/screens/inventory/inventory_form.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryService _service = InventoryService();
  String _searchQuery = "";

  void _openForm({InventoryModel? item}) {
    showDialog(
      context: context,
      builder: (_) => InventoryForm(
        item: item,
        onSubmit: (newItem) {
          setState(() {
            if (item == null) {
              _service.add(newItem);
            } else {
              _service.update(newItem);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final items = _service.getAll();
    final filtered = items
        .where((i) =>
            i.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            i.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            i.location.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    // --- MÉTRICAS DEL DASHBOARD ---
    final totalItems = items.length;
    final lowStock = items.where((item) => item.quantity < 3).length;
    final uniqueCategories =
        items.map((item) => item.category).toSet().length;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- DASHBOARD KPI ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard(
                    context,
                    icon: Icons.inventory_2,
                    label: "Total Ítems",
                    value: totalItems.toString(),
                    color: colors.primary,
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.warning_amber_rounded,
                    label: "Stock Bajo",
                    value: lowStock.toString(),
                    color: colors.error,
                  ),
                  _buildDashboardCard(
                    context,
                    icon: Icons.category,
                    label: "Categorías",
                    value: uniqueCategories.toString(),
                    color: colors.tertiary,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // --- BARRA DE BÚSQUEDA ---
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar ítem...",
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

              const SizedBox(height: 12),

              // --- LISTA DE ITEMS ---
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Divider(height: 12),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    final stockColor = item.quantity < 3
                        ? colors.error
                        : (item.quantity < 10
                            ? colors.tertiary
                            : colors.primary);

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(12),
                        leading: Icon(Icons.inventory_2_outlined,
                            color: stockColor, size: 32),
                        title: Text(
                          item.name,
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${item.category} • ${item.location}",
                                style: textTheme.bodyMedium),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.bar_chart,
                                    size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  "Stock: ${item.quantity}",
                                  style: TextStyle(
                                    color: stockColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert, color: Colors.black),
                          onSelected: (value) {
                            if (value == 'edit') {
                              _openForm(item: item);
                            } else if (value == 'delete') {
                              setState(() => _service.delete(item.id));
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'edit',
                              child: Row(
                                children: [
                                  Icon(Icons.edit, color: Colors.blue),
                                  SizedBox(width: 8),
                                  Text('Editar'),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'delete',
                              child: Row(
                                children: [
                                  Icon(Icons.delete, color: Colors.red),
                                  SizedBox(width: 8),
                                  Text('Eliminar'),
                                ],
                              ),
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
      ),

      // --- BOTÓN FLOTANTE ---
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: colors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          "Nuevo ítem",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // --- Tarjeta de Dashboard (KPI) ---
  Widget _buildDashboardCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 26),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
