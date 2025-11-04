class InventoryModel {
  final String id;
  final String name;
  final String category;
  final int quantity;
  final String location;

  InventoryModel({
    required this.id,
    required this.name,
    required this.category,
    required this.quantity,
    required this.location,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) => InventoryModel(
        id: json['id'].toString(),
        name: json['name'] ?? '',
        category: json['category'] ?? '',
        quantity: json['quantity'] ?? 0,
        location: json['location'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'quantity': quantity,
        'location': location,
      };
}
