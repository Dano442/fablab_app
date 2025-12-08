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

  List<InventoryModel> _items = [];
  String _searchQuery = "";
  bool _isLoading = true;

  String calcularEstado(int stock) {
    if (stock <= 0) return "No Disponible";
    if (stock < 3) return "Bajo Stock";
    if (stock < 10) return "Medio";
    return "Disponible";
  }

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
      builder: (_) => InventoryForm(
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
      builder: (_) => InventoryForm(
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

void _openFilteredList(String tipo) {
  List<InventoryModel> filtrados = [];

  if (tipo == "bajo") {
    filtrados = _items.where((i) => i.stock >= 1 && i.stock <= 5).toList();
  } else if (tipo == "sin") {
    filtrados = _items.where((i) => i.stock <= 0).toList();
  } else {
    filtrados = _items;
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: 45,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),

                Text(
                  tipo == "bajo"
                      ? "Ítems con Stock Bajo"
                      : tipo == "sin"
                          ? "Ítems sin Stock"
                          : "Ítems",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: filtrados.isEmpty
                      ? const Center(child: Text("No hay ítems en esta categoría"))
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          controller: controller,
                          itemCount: filtrados.length,
                          itemBuilder: (_, i) {
                            final item = filtrados[i];

                            return ListTile(
                              leading: Icon(
                                Icons.inventory_2,
                                color: item.stock <= 0
                                    ? Colors.red
                                    : item.stock < 3
                                        ? Colors.amber
                                        : Colors.green,
                              ),
                              title: Text(item.nombre),
                              subtitle:
                                  Text("${item.categoria} • ${item.ubicacion}"),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _openEditForm(item);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteItem(item);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filtered = _items.where((item) {
      final q = _searchQuery.toLowerCase();
      return item.nombre.toLowerCase().contains(q) ||
          item.categoria.toLowerCase().contains(q) ||
          item.ubicacion.toLowerCase().contains(q);
    }).toList();

    final totalItems = _items.length;
    final lowStock = _items.where((i) => i.stock >= 1 && i.stock <= 5).length;
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
                    onTap: () => _openFilteredList("todos"),
                  ),
                  _buildDashboardCard(
                    icon: Icons.warning_amber_rounded,
                    label: "Stock Bajo",
                    value: lowStock.toString(),
                    color: Colors.amber,
                    onTap: () => _openFilteredList("bajo"),
                  ),
                  _buildDashboardCard(
                    icon: Icons.block_flipped,
                    label: "Sin Stock",
                    value: sinStock.toString(),
                    color: Colors.red,
                    onTap: () => _openFilteredList("sin"),
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
                  onRefresh: _loadInventory,
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
                          itemCount: filtered.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 12),
                          itemBuilder: (_, i) {
                            final item = filtered[i];
                            final stockColor = item.stock < 3
                                ? colors.error
                                : item.stock < 10
                                    ? colors.tertiary
                                    : colors.primary;

                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${item.categoria} • ${item.ubicacion}"),
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
                                  itemBuilder: (_) => const [
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
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.4),
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
      ),
    );
  }
}
