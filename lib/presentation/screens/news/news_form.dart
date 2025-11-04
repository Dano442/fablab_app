import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/news_model.dart';

class NewsForm extends StatefulWidget {
  final NewsModel? news;
  final Function(NewsModel) onSubmit;

  const NewsForm({super.key, this.news, required this.onSubmit});

  @override
  State<NewsForm> createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.news?.title ?? '');
    _contentController = TextEditingController(text: widget.news?.content ?? '');
    _imageController = TextEditingController(text: widget.news?.imageUrl ?? '');
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newNews = NewsModel(
        id: widget.news?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageController.text.isEmpty
            ? 'https://picsum.photos/400'
            : _imageController.text,
        date: DateTime.now().toString().substring(0, 10),
      );
      widget.onSubmit(newNews);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return AlertDialog(
      title: Text(widget.news == null ? 'Nueva Noticia' : 'Editar Noticia'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Ingrese un título' : null,
            ),
            TextFormField(
              controller: _contentController,
              decoration: const InputDecoration(labelText: 'Contenido'),
              validator: (v) =>
                  v == null || v.isEmpty ? 'Ingrese contenido' : null,
              maxLines: 3,
            ),
            TextFormField(
              controller: _imageController,
              decoration:
                  const InputDecoration(labelText: 'URL de imagen (opcional)'),
            ),
          ],
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
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
