class BasketItem {
  final int productId;
  final String name;
  final String brand;
  final String type;
  final int price;
  int quantity;
  final String pictureUrl;

  BasketItem({
    required this.productId,
    required this.name,
    required this.brand,
    required this.type,
    required this.price,
    required this.quantity,
    required this.pictureUrl,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      productId: json['productId'] as int,
      name: json['name'] as String,
      brand: json['brand'] as String,
      type: json['type'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      pictureUrl: json['pictureUrl'] as String,
    );
  }

  @override
  String toString() {
    return 'BasketItem{productId: $productId, name: $name}';
  }
}
