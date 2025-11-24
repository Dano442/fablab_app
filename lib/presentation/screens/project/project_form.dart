import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/project_model.dart';

class ProjectForm extends StatefulWidget {
  final ProjectModel? project;
  final Function(ProjectModel) onSubmit;

  const ProjectForm({super.key, this.project, required this.onSubmit});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _categoriaController;
  late TextEditingController _descripcionController;
  late TextEditingController _areaController;
  late TextEditingController _imgUrlController;
  late TextEditingController _fechaInicioController;

  @override
  void initState() {
    super.initState();

    _tituloController =
        TextEditingController(text: widget.project?.titulo ?? '');

    _categoriaController =
        TextEditingController(text: widget.project?.categoria ?? '');

    _descripcionController =
        TextEditingController(text: widget.project?.descripcionProyecto ?? '');

    _areaController =
        TextEditingController(text: widget.project?.areaAplicacion ?? '');

    _imgUrlController =
        TextEditingController(text: widget.project?.imgUrl ?? '');

    // Fecha: si edita, usa la del backend; si crea, usa la de hoy
    final fecha = widget.project?.fechaInicio ?? DateTime.now();

    _fechaInicioController =
        TextEditingController(text: fecha.toIso8601String().split('T')[0]);
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _categoriaController.dispose();
    _descripcionController.dispose();
    _areaController.dispose();
    _imgUrlController.dispose();
    _fechaInicioController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final date = DateTime.parse(_fechaInicioController.text.trim());

      final newProject = ProjectModel(
        id: widget.project?.id ?? 0,     // 0 cuando es nuevo
        titulo: _tituloController.text.trim(),
        categoria: _categoriaController.text.trim(),
        descripcionProyecto: _descripcionController.text.trim(),
        areaAplicacion: _areaController.text.trim(),
        imgUrl: _imgUrlController.text.trim(),
        fechaInicio: DateTime(date.year, date.month, date.day),
        usuarios: widget.project?.usuarios ?? [],
        hitoProyecto: widget.project?.hitoProyecto ?? [],
      );

      widget.onSubmit(newProject);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isEditing = widget.project != null;

    return AlertDialog(
      title: Text(isEditing ? 'Editar Proyecto' : 'Nuevo Proyecto'),
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un título' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _categoriaController,
                decoration: const InputDecoration(labelText: 'Categoría'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _descripcionController,
                decoration:
                    const InputDecoration(labelText: 'Descripción del proyecto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese una descripción' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _areaController,
                decoration: const InputDecoration(labelText: 'Área de aplicación'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _imgUrlController,
                decoration:
                    const InputDecoration(labelText: 'URL de imagen (opcional)'),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _fechaInicioController,
                decoration:
                    const InputDecoration(labelText: 'Fecha (YYYY-MM-DD)'),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Ingrese una fecha';
                  final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
                  if (!regex.hasMatch(v)) return 'Formato incorrecto';
                  return null;
                },
              ),
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
          onPressed: _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
          ),
          child: Text(isEditing ? 'Guardar' : 'Crear'),
        ),
      ],
    );
  }
}
