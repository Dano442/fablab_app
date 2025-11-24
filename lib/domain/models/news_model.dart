class NewsModel {
  final int? id;
  final String titulo;
  final String epigrafe;
  final String autor;
  final DateTime? fechaPublicacion;
  final String contenido;
  final String? imageUrlPrincipal;
  final String? imageUrlAutor;
  final String estado;

  NewsModel({
    this.id,
    required this.titulo,
    required this.epigrafe,
    required this.autor,
    required this.fechaPublicacion,
    required this.contenido,
    required this.imageUrlPrincipal,
    required this.imageUrlAutor,
    required this.estado,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json["id"],
      titulo: json["titulo"],
      epigrafe: json["epigrafe"] ?? "",
      autor: json["autor"],
      fechaPublicacion: json["fechaPublicacion"] != null
          ? DateTime.parse(json["fechaPublicacion"])
          : null,
      contenido: json["contenido"],
      imageUrlPrincipal: json["imageUrlPrincipal"]?.toString(),
      imageUrlAutor: json["imageUrlAutor"]?.toString(),
      estado: json["estado"],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      "titulo": titulo,
      "epigrafe": epigrafe.isEmpty ? null : epigrafe,
      "autor": autor,
      "fechaPublicacion": fechaPublicacion?.toIso8601String(),
      "contenido": contenido,
      "imageUrlPrincipal":
          (imageUrlPrincipal == null || imageUrlPrincipal!.isEmpty)
              ? null
              : imageUrlPrincipal,
      "imageUrlAutor":
          (imageUrlAutor == null || imageUrlAutor!.isEmpty)
              ? null
              : imageUrlAutor,
      "estado": estado,
    };

    if (id != null) data["id"] = id;

    return data;
  }
}
