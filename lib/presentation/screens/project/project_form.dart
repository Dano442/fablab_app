import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/project_model.dart';
import 'package:uuid/uuid.dart';

class ProjectForm extends StatefulWidget {
  final ProjectModel? project;
  final Function(ProjectModel) onSubmit;

  const ProjectForm({super.key, this.project, required this.onSubmit});

  @override
  State<ProjectForm> createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid();

  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _ownerController;
  late TextEditingController _statusController;
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name ?? '');
    _descriptionController =
        TextEditingController(text: widget.project?.description ?? '');
    _ownerController =
        TextEditingController(text: widget.project?.owner ?? '');
    _statusController =
        TextEditingController(text: widget.project?.status ?? '');
    _dateController =
        TextEditingController(text: widget.project?.date ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _ownerController.dispose();
    _statusController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newProject = ProjectModel(
        id: widget.project?.id ?? _uuid.v4(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        owner: _ownerController.text.trim(),
        status: _statusController.text.trim(),
        date: _dateController.text.trim(),
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
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Ingrese un nombre' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Ingrese una descripción'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ownerController,
                decoration:
                    const InputDecoration(labelText: 'Responsable del proyecto'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Estado'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Fecha'),
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
          child: Text(isEditing ? 'Guardar cambios' : 'Crear'),
        ),
      ],
    );
  }
}
