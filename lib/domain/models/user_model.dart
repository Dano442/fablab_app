class UserModel {
  final String id;
  final String name;
  final String email;
  final String rut;
  final String career;
  final String role;
  final String project;
  final String imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.rut,
    required this.career,
    required this.role,
    required this.project,
    required this.imageUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        rut: json['rut'] ?? '',
        career: json['career'] ?? '',
        role: json['role'] ?? '',
        project: json['project'] ?? '',
        imageUrl: json['imageUrl'] ?? 'https://via.placeholder.com/150',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'rut': rut,
        'career': career,
        'role': role,
        'project': project,
        'imageUrl': imageUrl,
      };
}
