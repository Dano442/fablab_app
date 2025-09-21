import 'package:flutter/material.dart';

class News {
  final String title;
  final String description;
  final String imageUrl;

  News({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<News> _newsList = [
    News(
      title: "Nueva impresora 3D en el laboratorio",
      description:
          "Ahora contamos con una nueva impresora 3D de alta precisión para los proyectos de los estudiantes.",
      imageUrl: "https://via.placeholder.com/300x200",
    ),
    News(
      title: "Capacitación de seguridad",
      description:
          "La próxima semana se realizará una capacitación obligatoria sobre normas de seguridad en el FabLab.",
      imageUrl: "https://via.placeholder.com/300x200",
    ),
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final filteredNews = _newsList
        .where((news) =>
            news.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            news.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Título de la sección en el body
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              "Noticias",
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ),
          
          // Barra de búsqueda
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
              onChanged: (value) {
                setState(() => _searchQuery = value);
              },
            ),
          ),
          
          // Lista de noticias
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: filteredNews.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final news = filteredNews[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          news.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: colors.surfaceContainerHigh,
                              child: const Icon(Icons.broken_image, size: 50),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.title,
                              style: textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colors.onSurface,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              news.description,
                              style: textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: colors.primary),
                                  onPressed: () {
                                    debugPrint('Editar noticia: ${news.title}');
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: colors.error),
                                  onPressed: () {
                                    debugPrint('Eliminar noticia: ${news.title}');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}