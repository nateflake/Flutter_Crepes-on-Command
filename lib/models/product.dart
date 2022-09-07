class Product {
  final int id;
  final String name;
  final String description;
  final String type;
  final String brand;
  final int price;
  final int quantityInStock;
  final String pictureUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.brand,
    required this.price,
    required this.quantityInStock,
    required this.pictureUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      brand: json['brand'] as String,
      price: json['price'] as int,
      quantityInStock: json['quantityInStock'] as int,
      pictureUrl: json['pictureUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, description:$description,}';
  }
}
