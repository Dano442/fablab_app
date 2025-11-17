import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class UserForm extends StatefulWidget {
  final UserModel? user;
  final void Function(UserModel) onSubmit;

  const UserForm({super.key, this.user, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombre;
  late TextEditingController _apellido;
  late TextEditingController _rut;
  late TextEditingController _correo;
  late TextEditingController _carrera;
  late TextEditingController _telefono;

  @override
  void initState() {
    super.initState();

    _nombre = TextEditingController(text: widget.user?.nombre ?? "");
    _apellido = TextEditingController(text: widget.user?.apellido ?? "");
    _rut = TextEditingController(text: widget.user?.rut ?? "");
    _correo = TextEditingController(text: widget.user?.correoInstitucional ?? "");
    _carrera = TextEditingController(text: widget.user?.carrera ?? "");
    _telefono = TextEditingController(text: widget.user?.telefono ?? "");
  }

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _rut.dispose();
    _correo.dispose();
    _carrera.dispose();
    _telefono.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.user != null;
    final colors = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Text(isEditing ? "Editar Usuario" : "Nuevo Usuario"),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInput(_nombre, "Nombre"),
              _buildInput(_apellido, "Apellido"),
              _buildInput(_rut, "RUT"),
              _buildInput(_correo, "Correo institucional"),
              _buildInput(_carrera, "Carrera"),
              _buildInput(_telefono, "Teléfono", isNumber: true),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate()) return;

            final user = UserModel(
              id: isEditing ? widget.user!.id : null,
              nombre: _nombre.text.trim(),
              apellido: _apellido.text.trim(),
              rut: _rut.text.trim(),
              correoInstitucional: _correo.text.trim(),
              carrera: _carrera.text.trim(),
              telefono: _telefono.text.trim(),
              laboratorioId: widget.user?.laboratorioId,
              laboratorio: widget.user?.laboratorio,
              rolId: widget.user?.rolId ?? 2,
              tipoRol: widget.user?.tipoRol ?? "Miembro",
              descripcionRol: widget.user?.descripcionRol ?? "",
            );

            widget.onSubmit(user);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
          child: Text(isEditing ? "Guardar" : "Agregar"),
        )
      ],
    );
  }

  Widget _buildInput(TextEditingController c, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: c,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(labelText: label),
        validator: (v) =>
            v == null || v.isEmpty ? "Ingrese $label" : null,
      ),
    );
  }
}
