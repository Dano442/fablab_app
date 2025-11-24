class InventoryModel {
  final int? id;
  final String nombre;
  final String categoria;
  final int stock;
  final String ubicacion;
  final String descripcion;
  final String estado;

  InventoryModel({
    this.id,
    required this.nombre,
    required this.categoria,
    required this.stock,
    required this.ubicacion,
    required this.descripcion,
    required this.estado,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json["id"],
      nombre: json["nombre"],
      categoria: json["categoria"],
      stock: json["stock"],
      ubicacion: json["ubicacion"],
      descripcion: json["descripcion"],
      estado: json["estado"],
    );
  }

  Map<String, dynamic> toJsonPost() {
    return {
      "nombre": nombre,
      "categoria": categoria,
      "stock": stock,
      "ubicacion": ubicacion,
      "descripcion": descripcion ,
      "estado": estado,
    };
  }

  Map<String, dynamic> toJsonPut() {
    return {
      "nombre": nombre,
      "categoria": categoria,
      "stock": stock,
      "ubicacion": ubicacion,
    };
  }
}
