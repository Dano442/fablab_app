class NewsModel {
  final String id;
  final String title;
  final String content;
  final String date;
  final String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
  });

  NewsModel copyWith({
    String? id,
    String? title,
    String? content,
    String? date,
    String? imageUrl,
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
