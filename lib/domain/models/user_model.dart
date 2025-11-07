class UserModel {
  final int id;
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
    required this.id,
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
    final rolData = json['rol'] ?? {};
    final labData = json['laboratorio'];

    return UserModel(
      id: json['id'] ?? 0,
      nombre: json['nombre'] ?? '',
      apellido: json['apellido'] ?? '',
      rut: json['rut'] ?? '',
      correoInstitucional: json['correoInstitucional'] ?? '',
      carrera: json['carrera'] ?? '',
      telefono: json['telefono'] ?? '',
      laboratorioId: json['laboratorioId'],
      laboratorio: labData is Map<String, dynamic>
          ? labData['nombre'] ?? ''
          : (labData?.toString() ?? ''),
      rolId: json['rolId'] ?? 0,
      tipoRol: rolData['tipoRol'] ?? '',
      descripcionRol: rolData['descripcionRol'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'rut': rut,
      'correoInstitucional': correoInstitucional,
      'carrera': carrera,
      'telefono': telefono,
      'laboratorioId': laboratorioId,
      // Solo se envía el ID, no el objeto anidado
      'rolId': rolId,
    };
  }

  String get nombreCompleto => "$nombre $apellido";
}
