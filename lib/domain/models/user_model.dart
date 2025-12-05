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
  final String? imgUrl; 

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
    this.imgUrl,
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
      imgUrl: json["imgUrl"],
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
      "imgUrl": imgUrl,
    };

    if (id != null) {
      data["id"] = id;
    }

    return data;
  }
  UserModel copyWith({
    int? id,
    String? nombre,
    String? apellido,
    String? rut,
    String? correoInstitucional,
    String? carrera,
    String? telefono,
    int? laboratorioId,
    String? laboratorio,
    int? rolId,
    String? tipoRol,
    String? descripcionRol,
    String? imgUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      apellido: apellido ?? this.apellido,
      rut: rut ?? this.rut,
      correoInstitucional: correoInstitucional ?? this.correoInstitucional,
      carrera: carrera ?? this.carrera,
      telefono: telefono ?? this.telefono,
      laboratorioId: laboratorioId ?? this.laboratorioId,
      laboratorio: laboratorio ?? this.laboratorio,
      rolId: rolId ?? this.rolId,
      tipoRol: tipoRol ?? this.tipoRol,
      descripcionRol: descripcionRol ?? this.descripcionRol,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  String get nombreCompleto => "$nombre $apellido";
}
