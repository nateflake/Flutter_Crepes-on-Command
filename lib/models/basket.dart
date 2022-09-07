import 'package:crepes/models/basket_item.dart';

class Basket {
  final int id;
  final List<BasketItem> items;

  Basket({required this.id, required this.items});

  factory Basket.fromJson(Map<String, dynamic> json) {
    var basketItems = <BasketItem>[];
    json['items'].forEach((list) {
      basketItems.add(BasketItem.fromJson(list));
    });

    return Basket(
      id: json['id'] as int,
      items: basketItems,
    );
  }

  @override
  String toString() {
    return 'Basket{id: $id, items: $items}';
  }
}
