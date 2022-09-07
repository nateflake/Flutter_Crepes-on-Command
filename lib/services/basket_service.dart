import 'dart:convert';
import 'package:crepes/constants/constants.dart';
import 'package:crepes/models/basket.dart';
import 'package:crepes/models/basket_item.dart';
import 'package:http/http.dart';

class BasketService {
  static final BasketService _service = BasketService._internal();

  factory BasketService() {
    return _service;
  }

  BasketService._internal();

  List<BasketItem> basketItems = [];

  Future<List<BasketItem>> getBasketItems() async {
    Response res = await get(Uri.parse(basketUrl));

    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      var items = <BasketItem>[];
      json['items'].forEach((list) {
        items.add(BasketItem.fromJson(list));
      });

      basketItems = items;
      return basketItems;
    } else {
      throw "Failed to load basket Items";
    }
  }

  Future<bool> checkForBasketItemById(int productId) async {
    final idString = productId.toString();
    final response = await get(Uri.parse('$basketUrl/$idString'));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<BasketItem?> getBasketItemById(int productId) async {
    final response = await get(Uri.parse(basketUrl));

    if (response.statusCode == 200) {
      final basket = Basket.fromJson(json.decode(response.body));
      var items = basket.items.where((item) => item.productId == productId);
      return items.isEmpty ? null : items.first;
    } else {
      return null;
    }
  }

  updateProductQuantityInBasket(int id, int amount) async {
    final Response response = await post(
      Uri.parse('$basketUrl?productId=$id&quantity=$amount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      basketItems = await getBasketItems();
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<int> deleteBasketItem(int productId) async {
    if ((await delete(Uri.parse('$basketUrl/$productId'))).statusCode == 200) {
      basketItems = await getBasketItems();
      return 1;
    } else {
      return 0;
    }
  }

  int getQuantity(int productId) {
    final matches = basketItems.where((element) => element.productId == productId);
    if (matches.isEmpty) return 0;

    return matches.first.quantity;
  }

  int getQuantityTotal() {
    final matches = basketItems.where((element) => element.quantity > 0);
    if (matches.isEmpty) return 0;

    var sum = 0;
    for (final item in matches) {
      sum += item.quantity;
    }

    return sum;
  }
}
