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

  late TextEditingController nombre;
  late TextEditingController categoria;
  late TextEditingController stock;
  late TextEditingController ubicacion;
  late TextEditingController descripcion;

  @override
  void initState() {
    super.initState();
    nombre = TextEditingController(text: widget.item?.nombre ?? "");
    categoria = TextEditingController(text: widget.item?.categoria ?? "");
    stock = TextEditingController(text: widget.item?.stock.toString() ?? "");
    ubicacion = TextEditingController(text: widget.item?.ubicacion ?? "");
    descripcion = TextEditingController(text: widget.item?.descripcion ?? "");
  }

  String calcularEstado(int stock) {
    if(stock <= 0) return "No Disponible";
    if (stock < 3) return "Bajo Stock";
    if (stock < 10) return "Medio";
    return "Disponible";
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final int stockValue = int.parse(stock.text.trim());
      final String estadoGenerado = calcularEstado(stockValue);

      widget.onSubmit(
        InventoryModel(
          id: widget.item?.id,
          nombre: nombre.text.trim(),
          categoria: categoria.text.trim(),
          stock: stockValue,
          ubicacion: ubicacion.text.trim(),
          descripcion: descripcion.text.trim(),
          estado: estadoGenerado,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.item != null;

    return AlertDialog(
      title: Text(isEdit ? "Editar Ítem" : "Nuevo Ítem"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nombre,
              decoration: const InputDecoration(labelText: "Nombre"),
              validator: (v) => v!.isEmpty ? "Requerido" : null,
            ),
            TextFormField(
              controller: categoria,
              decoration: const InputDecoration(labelText: "Categoría"),
              validator: (v) => v!.isEmpty ? "Requerido" : null,
            ),
            TextFormField(
              controller: stock,
              decoration: const InputDecoration(labelText: "Stock"),
              keyboardType: TextInputType.number,
              validator: (v) => v!.isEmpty ? "Requerido" : null,
            ),
            TextFormField(
              controller: ubicacion,
              decoration: const InputDecoration(labelText: "Ubicación"),
              validator: (v) => v!.isEmpty ? "Requerido" : null,
            ),
            TextFormField(
              controller: descripcion,
              decoration: const InputDecoration(labelText: "Descripción"),
              validator: (v) => v!.isEmpty ? "Requerido" : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
