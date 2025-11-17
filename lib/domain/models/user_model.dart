class UserModel {
  final int? id;
  final String nombre;
  final String apellido;
  final String rut;
  final String correoInstitucional;
  final String carrera;
  final String telefono;
  final int? laboratorioId;
  final String? laboratorio;
  final int rolId;
  final String tipoRol;
  final String descripcionRol;

  UserModel({
    this.id,
    required this.nombre,
    required this.apellido,
    required this.rut,
    required this.correoInstitucional,
    required this.carrera,
    required this.telefono,
    this.laboratorioId,
    this.laboratorio,
    required this.rolId,
    required this.tipoRol,
    required this.descripcionRol,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    final rol = json["rol"] ?? {};
    final lab = json["laboratorio"];

    return UserModel(
      id: json["id"],
      nombre: json["nombre"] ?? "",
      apellido: json["apellido"] ?? "",
      rut: json["rut"] ?? "",
      correoInstitucional: json["correoInstitucional"] ?? "",
      carrera: json["carrera"] ?? "",
      telefono: json["telefono"] ?? "",
      laboratorioId: json["laboratorioId"],
      laboratorio: lab is Map<String, dynamic> ? lab["nombre"] ?? "" : null,
      rolId: json["rolId"] ?? 0,
      tipoRol: rol["tipoRol"] ?? "",
      descripcionRol: rol["descripcionRol"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      "nombre": nombre,
      "apellido": apellido,
      "rut": rut,
      "correoInstitucional": correoInstitucional,
      "carrera": carrera,
      "telefono": telefono,
      "laboratorioId": laboratorioId,
      "rolId": rolId,
    };

    if (id != null) {
      data["id"] = id;
    }

    return data;
  }

  String get nombreCompleto => "$nombre $apellido";
}
