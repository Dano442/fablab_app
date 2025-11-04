import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/request_model.dart';

class RequestForm extends StatefulWidget {
  final RequestModel? item;
  final Function(RequestModel) onSubmit;

  const RequestForm({super.key, this.item, required this.onSubmit});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late TextEditingController _requester;
  String _status = "Pendiente";

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.item?.title ?? '');
    _desc = TextEditingController(text: widget.item?.description ?? '');
    _requester = TextEditingController(text: widget.item?.requester ?? '');
    _status = widget.item?.status ?? "Pendiente";
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(widget.item == null ? "Nueva Solicitud" : "Editar Solicitud"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _desc,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            TextField(
              controller: _requester,
              decoration: const InputDecoration(labelText: 'Solicitante'),
            ),
            DropdownButtonFormField<String>(
              initialValue: _status,
              decoration: const InputDecoration(labelText: 'Estado'),
              items: const [
                DropdownMenuItem(value: "Pendiente", child: Text("Pendiente")),
                DropdownMenuItem(value: "Aprobada", child: Text("Aprobada")),
                DropdownMenuItem(value: "Rechazada", child: Text("Rechazada")),
              ],
              onChanged: (value) => setState(() => _status = value!),
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
          style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
          onPressed: () {
            final req = RequestModel(
              id: widget.item?.id ??
                  DateTime.now().millisecondsSinceEpoch.toString(),
              title: _title.text,
              description: _desc.text,
              requester: _requester.text,
              status: _status,
              date: DateTime.now(),
            );
            widget.onSubmit(req);
            Navigator.pop(context);
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
