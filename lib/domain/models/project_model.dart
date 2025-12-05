class ProjectModel {
  final int id;
  final String titulo;
  final String? categoria;
  final String? descripcionProyecto;
  final String? areaAplicacion;
  final String? imgUrl;
  final DateTime? fechaInicio;

  final List<UsuarioProyecto> usuarios;
  final List<HitoProyecto> hitoProyecto;

  ProjectModel({
    required this.id,
    required this.titulo,
    this.categoria,
    this.descripcionProyecto,
    this.areaAplicacion,
    this.imgUrl,
    this.fechaInicio,
    required this.usuarios,
    required this.hitoProyecto,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json["id"],
      titulo: json["titulo"] ?? "Sin título",
      categoria: json["categoria"],
      descripcionProyecto: json["descripcionProyecto"],
      areaAplicacion: json["areaAplicacion"],
      imgUrl: json["imgUrl"],
      fechaInicio: json["fechaInicio"] != null
          ? DateTime.tryParse(json["fechaInicio"])
          : null,

      // Usuarios tipados
      usuarios: (json["usuarios"] as List? ?? [])
          .map((u) => UsuarioProyecto.fromJson(u))
          .toList(),

      // Hitos tipados
      hitoProyecto: (json["hitoProyecto"] as List? ?? [])
          .map((h) => HitoProyecto.fromJson(h))
          .toList(),
    );
  }
}

class UsuarioProyecto {
  final int id;
  final String nombre;
  final String apellido;
  final String correoInstitucional;
  final String? imgUrl;

  UsuarioProyecto({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correoInstitucional,
    this.imgUrl,
  });

  factory UsuarioProyecto.fromJson(Map<String, dynamic> json) {
    return UsuarioProyecto(
      id: json["id"],
      nombre: json["nombre"] ?? "",
      apellido: json["apellido"] ?? "",
      correoInstitucional: json["correoInstitucional"] ?? "",
      imgUrl: json["imgUrl"],
    );
  }
}

class HitoProyecto {
  final int id;
  final String nombreHito;
  final String descripcion;
  final DateTime fecha;

  HitoProyecto({
    required this.id,
    required this.nombreHito,
    required this.descripcion,
    required this.fecha,
  });

  factory HitoProyecto.fromJson(Map<String, dynamic> json) {
    return HitoProyecto(
      id: json["id"],
      nombreHito: json["nombreHito"] ?? "",
      descripcion: json["descripcion"] ?? "",
      fecha: DateTime.parse(json["fecha"]),
    );
  }
}
