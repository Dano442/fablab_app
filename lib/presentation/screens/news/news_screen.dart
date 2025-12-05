import 'package:flutter/material.dart';
import 'package:fablab_app/data/services/news_service.dart';
import 'package:fablab_app/domain/models/news_model.dart';
import 'package:fablab_app/presentation/screens/news/news_card.dart';
import 'package:fablab_app/presentation/screens/news/news_form.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _service = NewsService();

  List<NewsModel> _news = [];
  String _search = "";
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    setState(() => _loading = true);

    final fetched = await _service.getAllNews();

    fetched.sort((a, b) {
      final fa = a.fechaPublicacion ?? DateTime(1990);
      final fb = b.fechaPublicacion ?? DateTime(1990);
      return fb.compareTo(fa);
    });

    if (mounted) {
      setState(() {
        _news = fetched;
        _loading = false;
      });
    }
  }

  void _openForm({NewsModel? news}) {
    showDialog(
      context: context,
      builder: (_) => NewsForm(
        news: news,
        onSubmit: (noticia) async {
          bool ok;

          if (news == null) {
            ok = await _service.createNews(noticia);
            if (ok) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Noticia creada")),
              );
            }
          } else {
            ok = await _service.updateNews(noticia);
            if (ok) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Noticia actualizada")),
              );
            }
          }

          await _loadNews();
        },
      ),
    );
  }

  Future<void> _deleteNews(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Eliminar noticia"),
        content: const Text("¿Deseas eliminar esta noticia?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text(
              "Eliminar",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

if (confirmed == true) {
  final ok = await _service.deleteNews(id);

  if (!mounted) return;

  if (ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Noticia eliminada")),
    );

    await _loadNews();

    if (!mounted) return;
  }
}

  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final filtered = _news.where((n) {
      final q = _search.toLowerCase();
      return n.titulo.toLowerCase().contains(q) ||
          n.epigrafe.toLowerCase().contains(q) ||
          n.contenido.toLowerCase().contains(q) ||
          n.autor.toLowerCase().contains(q);
    }).toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(news: null),
        label: const Text("Nueva noticia"),
        icon: const Icon(Icons.add),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar noticia...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: colors.surfaceContainerHighest,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),

          const SizedBox(height: 12),

          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : filtered.isEmpty
                    ? const Center(child: Text("No hay noticias disponibles"))
                    : RefreshIndicator(
                        onRefresh: _loadNews,
                        child: ListView.separated(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 80),
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: 16),
                          itemBuilder: (_, index) {
                            final item = filtered[index];
                            return NewsCard(
                              news: item,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(item.titulo),
                                    content: Text(item.contenido),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dialogContext).pop(),
                                        child: const Text("Cerrar"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              onEdit: () => _openForm(news: item),
                              onDelete: () => _deleteNews(item.id!),
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
