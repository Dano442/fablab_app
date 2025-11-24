class ProjectModel {
  final int id;
  final String titulo;
  final String categoria;
  final String descripcionProyecto;
  final String areaAplicacion;
  final String imgUrl;
  final DateTime fechaInicio;
  final List<dynamic> usuarios;
  final List<dynamic> hitoProyecto;

  ProjectModel({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.descripcionProyecto,
    required this.areaAplicacion,
    required this.imgUrl,
    required this.fechaInicio,
    required this.usuarios,
    required this.hitoProyecto,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      titulo: json["titulo"],
      categoria: json["categoria"],
      descripcionProyecto: json["descripcionProyecto"],
      areaAplicacion: json["areaAplicacion"],
      imgUrl: json["imgUrl"],
      fechaInicio: DateTime.parse(json["fechaInicio"]),
      usuarios: json["usuarios"] ?? [],
      hitoProyecto: json["hitoProyecto"] ?? [],
    );
  }
}
