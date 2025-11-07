import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/user_model.dart';

class UserForm extends StatefulWidget {
  final UserModel? user;
  final void Function(UserModel user) onSubmit;

  const UserForm({super.key, this.user, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nombre;
  late TextEditingController _apellido;
  late TextEditingController _correo;
  late TextEditingController _rut;
  late TextEditingController _carrera;
  late TextEditingController _telefono;
  late TextEditingController _rol;

  @override
  void initState() {
    super.initState();
    _nombre = TextEditingController(text: widget.user?.nombre ?? '');
    _apellido = TextEditingController(text: widget.user?.apellido ?? '');
    _correo =
        TextEditingController(text: widget.user?.correoInstitucional ?? '');
    _rut = TextEditingController(text: widget.user?.rut ?? '');
    _carrera = TextEditingController(text: widget.user?.carrera ?? '');
    _telefono = TextEditingController(text: widget.user?.telefono ?? '');
    _rol = TextEditingController(text: widget.user?.tipoRol ?? '');
  }

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _correo.dispose();
    _rut.dispose();
    _carrera.dispose();
    _telefono.dispose();
    _rol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isEditing = widget.user != null;

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(isEditing ? 'Editar Usuario' : 'Nuevo Usuario'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildField(_nombre, 'Nombre'),
              _buildField(_apellido, 'Apellido'),
              _buildField(_correo, 'Correo institucional'),
              _buildField(_rut, 'RUT'),
              _buildField(_carrera, 'Carrera'),
              _buildField(_telefono, 'Teléfono', isRequired: false),
              _buildField(_rol, 'Rol', isRequired: false),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final user = UserModel(
                id: widget.user?.id ?? 0,
                nombre: _nombre.text.trim(),
                apellido: _apellido.text.trim(),
                rut: _rut.text.trim(),
                correoInstitucional: _correo.text.trim(),
                carrera: _carrera.text.trim(),
                telefono: _telefono.text.trim(),
                laboratorioId: widget.user?.laboratorioId,
                laboratorio: widget.user?.laboratorio,
                rolId: widget.user?.rolId ?? 2,
                tipoRol: _rol.text.trim().isNotEmpty
                    ? _rol.text.trim()
                    : (widget.user?.tipoRol ?? 'Miembro'),
                descripcionRol:
                    widget.user?.descripcionRol ?? 'Sin descripción',
              );

              widget.onSubmit(user);
              Navigator.pop(context);
            }
          },
          child: Text(isEditing ? 'Guardar' : 'Agregar'),
        ),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String label,
      {bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(labelText: label),
        validator: isRequired
            ? (v) => v == null || v.isEmpty ? 'Ingrese $label' : null
            : null,
      ),
    );
  }
}
