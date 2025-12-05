import 'package:flutter/material.dart';
import 'package:fablab_app/data/services/inventory_service.dart';
import 'package:fablab_app/domain/models/inventory_model.dart';
import 'package:fablab_app/presentation/screens/inventory/inventory_form.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final InventoryService _service = InventoryService();
  String calcularEstado(int stock) {
    if (stock <= 0) return "No Disponible";
    if (stock < 3) return "Bajo Stock";
    if (stock < 10) return "Medio";
    return "Disponible";
  }

  List<InventoryModel> _items = [];
  String _searchQuery = "";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInventory();
  }

  Future<void> _loadInventory() async {
    setState(() => _isLoading = true);
    final data = await _service.getInventory();
    setState(() {
      _items = data;
      _isLoading = false;
    });
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: const Duration(seconds: 2)),
    );
  }

  void _openCreateForm() {
    showDialog(
      context: context,
      builder:
          (_) => InventoryForm(
            onSubmit: (newItem) async {
              await _service.createInventory(newItem);
              await _loadInventory();
              _showMessage("Ítem creado");
            },
          ),
    );
  }

  void _openEditForm(InventoryModel item) {
    showDialog(
      context: context,
      builder:
          (_) => InventoryForm(
            item: item,
            onSubmit: (updatedItem) async {
              await _service.updateInventory(item.id!, updatedItem);
              await _loadInventory();
              _showMessage("Ítem actualizado");
            },
          ),
    );
  }

  void _deleteItem(InventoryModel item) async {
    await _service.deleteInventory(item.id!);
    await _loadInventory();
    _showMessage("Ítem eliminado");
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filtered =
        _items.where((item) {
          final q = _searchQuery.toLowerCase();
          return item.nombre.toLowerCase().contains(q) ||
              item.categoria.toLowerCase().contains(q) ||
              item.ubicacion.toLowerCase().contains(q);
        }).toList();

    final totalItems = _items.length;
    final lowStock = _items.where((i) => i.stock >= 1 && i.stock <=5 ).length;
    final sinStock = _items.where((i) => i.stock <= 0).length;

    return Scaffold(
      backgroundColor: colors.surface,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDashboardCard(
                    icon: Icons.inventory_2,
                    label: "Total Ítems",
                    value: totalItems.toString(),
                    color: Colors.green,
                  ),
                  _buildDashboardCard(
                    icon: Icons.warning_amber_rounded,
                    label: "Stock Bajo",
                    value: lowStock.toString(),
                    color: Colors.amber,
                  ),
                  _buildDashboardCard(
                    icon: Icons.block_flipped,
                    label: "Sin Stock",
                    value: sinStock.toString(),
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 16),

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
                onChanged: (v) => setState(() => _searchQuery = v),
              ),

              const SizedBox(height: 12),

              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await _loadInventory();
                  },
                  child:
                      _isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
                            itemCount: filtered.length,
                            separatorBuilder:
                                (_, _) => const Divider(height: 12),
                            itemBuilder: (_, i) {
                              final item = filtered[i];

                              final stockColor =
                                  item.stock < 3
                                      ? colors.error
                                      : item.stock < 10
                                      ? colors.tertiary
                                      : colors.primary;

                              return Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(12),
                                  leading: Icon(
                                    Icons.inventory_2_outlined,
                                    color: stockColor,
                                    size: 32,
                                  ),
                                  title: Text(
                                    item.nombre,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.categoria} • ${item.ubicacion}",
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.bar_chart,
                                            size: 16,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Stock: ${item.stock}",
                                            style: TextStyle(
                                              color: stockColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  trailing: PopupMenuButton(
                                    onSelected: (value) {
                                      if (value == 'edit') {
                                        _openEditForm(item);
                                      } else if (value == 'delete') {
                                        _deleteItem(item);
                                      }
                                    },
                                    itemBuilder:
                                        (_) => const [
                                          PopupMenuItem(
                                            value: 'edit',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit, size: 18),
                                                SizedBox(width: 8),
                                                Text("Editar"),
                                              ],
                                            ),
                                          ),
                                          PopupMenuItem(
                                            value: 'delete',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete, size: 18),
                                                SizedBox(width: 8),
                                                Text("Eliminar"),
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
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openCreateForm,
        icon: const Icon(Icons.add),
        label: const Text("Nuevo ítem"),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        ),
        
      );
  }

  Widget _buildDashboardCard({
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
            ),
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
