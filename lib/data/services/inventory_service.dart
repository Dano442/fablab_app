import 'package:fablab_app/domain/models/inventory_model.dart';

class InventoryService {
  final List<InventoryModel> _items = [
    InventoryModel(
      id: '1',
      name: 'Impresora 3D Prusa',
      category: 'Impresoras',
      quantity: 2,
      location: 'Taller Principal',
    ),
    InventoryModel(
      id: '2',
      name: 'Cortadora Láser',
      category: 'Corte',
      quantity: 1,
      location: 'Área de Fabricación',
    ),
  ];

  List<InventoryModel> getAll() => List.from(_items);

  void add(InventoryModel item) => _items.add(item);

  void update(InventoryModel updated) {
    final index = _items.indexWhere((i) => i.id == updated.id);
    if (index != -1) _items[index] = updated;
  }

  void delete(String id) => _items.removeWhere((i) => i.id == id);
}
