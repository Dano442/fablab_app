import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/inventory_model.dart';

class InventoryForm extends StatefulWidget {
  final InventoryModel? item;
  final Function(InventoryModel) onSubmit;

  const InventoryForm({super.key, this.item, required this.onSubmit});

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController categoryController;
  late TextEditingController quantityController;
  late TextEditingController locationController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.item?.name ?? '');
    categoryController = TextEditingController(text: widget.item?.category ?? '');
    quantityController = TextEditingController(text: widget.item?.quantity.toString() ?? '');
    locationController = TextEditingController(text: widget.item?.location ?? '');
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(InventoryModel(
        id: widget.item?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        category: categoryController.text.trim(),
        quantity: int.tryParse(quantityController.text.trim()) ?? 0,
        location: locationController.text.trim(),
      ));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.item == null ? 'Nuevo Ítem' : 'Editar Ítem'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Ingrese un nombre' : null,
              ),
              TextFormField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              TextFormField(
                controller: quantityController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Ubicación'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(onPressed: _save, child: const Text('Guardar')),
      ],
    );
  }
}
