import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/news_model.dart';

class NewsForm extends StatefulWidget {
  final NewsModel? news;
  final Function(NewsModel) onSubmit;

  const NewsForm({
    super.key,
    this.news,
    required this.onSubmit,
  });

  @override
  State<NewsForm> createState() => _NewsFormState();
}

class _NewsFormState extends State<NewsForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _tituloController;
  late TextEditingController _epigrafeController;
  late TextEditingController _autorController;
  late TextEditingController _contenidoController;
  late TextEditingController _imgPrincipalController;
  late TextEditingController _imgAutorController;

  String estado = "Activo";

  @override
  void initState() {
    super.initState();

    _tituloController = TextEditingController(text: widget.news?.titulo ?? "");
    _epigrafeController = TextEditingController(text: widget.news?.epigrafe ?? "");
    _autorController = TextEditingController(text: widget.news?.autor ?? "");
    _contenidoController = TextEditingController(text: widget.news?.contenido ?? "");
    _imgPrincipalController = TextEditingController(text: widget.news?.imageUrlPrincipal ?? "");
    _imgAutorController = TextEditingController(text: widget.news?.imageUrlAutor ?? "");

    estado = widget.news?.estado ?? "Activo";
  }

  bool _isValidUrl(String text) {
    final t = text.trim();
    if (t.isEmpty) return false;
    return t.startsWith("http://") || t.startsWith("https://");
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final noticia = NewsModel(
      id: widget.news?.id,
      titulo: _tituloController.text.trim(),
      epigrafe: _epigrafeController.text.trim().isEmpty
          ? ""
          : _epigrafeController.text.trim(),
      autor: _autorController.text.trim(),
      fechaPublicacion: widget.news?.fechaPublicacion ?? DateTime.now(),
      contenido: _contenidoController.text.trim(),

      // -------- CORREGIDO: solo enviamos URL válida, si no → null --------
      imageUrlPrincipal: _isValidUrl(_imgPrincipalController.text)
          ? _imgPrincipalController.text.trim()
          : null,

      imageUrlAutor: _isValidUrl(_imgAutorController.text)
          ? _imgAutorController.text.trim()
          : null,
      // --------------------------------------------------------------------

      estado: estado,
    );

    widget.onSubmit(noticia);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxHeight: 620),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.news == null
                      ? "Crear nueva noticia"
                      : "Editar noticia",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colors.primary,
                  ),
                ),

                const SizedBox(height: 12),

                TextFormField(
                  controller: _tituloController,
                  decoration: const InputDecoration(labelText: "Título"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Ingrese un título" : null,
                ),

                TextFormField(
                  controller: _epigrafeController,
                  decoration: const InputDecoration(labelText: "Epígrafe"),
                ),

                TextFormField(
                  controller: _autorController,
                  decoration: const InputDecoration(labelText: "Autor"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Ingrese autor" : null,
                ),

                TextFormField(
                  controller: _contenidoController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: "Contenido"),
                  validator: (v) =>
                      v == null || v.isEmpty ? "Ingrese el contenido" : null,
                ),

                TextFormField(
                  controller: _imgPrincipalController,
                  decoration:
                      const InputDecoration(labelText: "Imagen Principal (URL)"),
                ),

                TextFormField(
                  controller: _imgAutorController,
                  decoration:
                      const InputDecoration(labelText: "Imagen Autor (URL)"),
                ),

                DropdownButtonFormField(
                  initialValue: estado,
                  items: const [
                    DropdownMenuItem(
                        value: "Activo", child: Text("Activo")),
                    DropdownMenuItem(
                        value: "Deshabilitado", child: Text("Deshabilitado")),
                  ],
                  onChanged: (v) => setState(() => estado = v!),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Cancelar"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                      ),
                      child: const Text("Guardar"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
