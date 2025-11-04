import 'package:flutter/material.dart';
import 'package:fablab_app/domain/models/news_model.dart';
import 'package:fablab_app/presentation/screens/news/news_card.dart';
import 'package:fablab_app/presentation/screens/news/news_form.dart';
import 'package:fablab_app/data/services/news_service.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final NewsService _service = NewsService();
  String _searchQuery = "";

  void _addNews(NewsModel news) {
    setState(() => _service.addNews(news));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Noticia agregada')),
    );
  }

  void _editNews(NewsModel news) {
    setState(() => _service.updateNews(news));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Noticia actualizada')),
    );
  }

  Future<void> _deleteNews(String id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar Noticia'),
        content: const Text('¿Estás seguro de que deseas eliminar esta noticia?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _service.deleteNews(id));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Noticia eliminada correctamente')),
      );
    }
  }

  void _openForm({NewsModel? news}) {
    showDialog(
      context: context,
      builder: (_) => NewsForm(
        news: news,
        onSubmit: news == null ? _addNews : _editNews,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final filteredNews = _service
        .getAllNews()
        .where((n) =>
            n.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            n.content.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        label: const Text('Nueva Noticia'),
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
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filteredNews.isEmpty
                ? const Center(child: Text('No hay noticias disponibles'))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredNews.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final news = filteredNews[index];
                      return NewsCard(
                        news: news,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => AlertDialog(
                              title: Text(news.title),
                              content: Text(news.content),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  child: const Text('Cerrar'),
                                ),
                              ],
                            ),
                          );
                        },
                        onEdit: () => _openForm(news: news),
                        onDelete: () => _deleteNews(news.id),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
