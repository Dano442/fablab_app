class RequestModel {
  final String id;
  final String title;
  final String description;
  final String requester;
  final String status; 
  final DateTime date;

  RequestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.requester,
    required this.status,
    required this.date,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json['id'].toString(),
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        requester: json['requester'] ?? '',
        status: json['status'] ?? 'Pendiente',
        date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      );
}
