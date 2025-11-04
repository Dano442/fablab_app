import 'package:fablab_app/domain/models/news_model.dart';

class NewsService {
  final List<NewsModel> _news = [
    NewsModel(
      id: '1',
      title: 'Nuevo prototipo impreso en 3D',
      content:
          'El equipo FabLab ha completado la impresión del nuevo prototipo robótico, marcando un gran avance en diseño y precisión.',
      date: '25/10/2025',
      imageUrl: 'https://picsum.photos/400?random=12',
    ),
    NewsModel(
      id: '2',
      title: 'Capacitación de impresión avanzada',
      content:
          'Se realizó una jornada de capacitación sobre técnicas avanzadas de impresión 3D con materiales reciclados.',
      date: '20/10/2025',
      imageUrl: 'https://picsum.photos/400?random=13',
    ),
  ];

  List<NewsModel> getAllNews() => List.unmodifiable(_news);

  void addNews(NewsModel news) {
    _news.add(news);
  }

  void updateNews(NewsModel updated) {
    final index = _news.indexWhere((n) => n.id == updated.id);
    if (index != -1) _news[index] = updated;
  }

  void deleteNews(String id) {
    _news.removeWhere((n) => n.id == id);
  }
}
