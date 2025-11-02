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

  late TextEditingController _name;
  late TextEditingController _email;
  late TextEditingController _rut;
  late TextEditingController _career;
  late TextEditingController _role;
  late TextEditingController _project;
  late TextEditingController _imageUrl;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.user?.name ?? '');
    _email = TextEditingController(text: widget.user?.email ?? '');
    _rut = TextEditingController(text: widget.user?.rut ?? '');
    _career = TextEditingController(text: widget.user?.career ?? '');
    _role = TextEditingController(text: widget.user?.role ?? '');
    _project = TextEditingController(text: widget.user?.project ?? '');
    _imageUrl = TextEditingController(text: widget.user?.imageUrl ?? '');
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
              _buildField(_name, 'Nombre'),
              _buildField(_email, 'Correo'),
              _buildField(_rut, 'RUT'),
              _buildField(_career, 'Carrera'),
              _buildField(_role, 'Rol'),
              _buildField(_project, 'Proyecto'),
              _buildField(_imageUrl, 'URL de Imagen (opcional)', isRequired: false),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: colors.primary),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final user = UserModel(
                id: widget.user?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
                name: _name.text.trim(),
                email: _email.text.trim(),
                rut: _rut.text.trim(),
                career: _career.text.trim(),
                role: _role.text.trim(),
                project: _project.text.trim(),
                imageUrl: _imageUrl.text.trim().isEmpty
                    ? 'https://via.placeholder.com/150'
                    : _imageUrl.text.trim(),
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
        validator: isRequired ? (v) => v!.isEmpty ? 'Ingrese $label' : null : null,
      ),
    );
  }
}
