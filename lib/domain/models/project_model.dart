class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String owner;
  final String status;
  final String date;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.status,
    required this.date,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        owner: json['owner'] ?? '',
        status: json['status'] ?? '',
        date: json['date'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'owner': owner,
        'status': status,
        'date': date,
      };
}
