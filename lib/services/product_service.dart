import 'dart:convert';
import 'package:crepes/constants/constants.dart';
import 'package:crepes/models/product.dart';
import 'package:http/http.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    Response res = await get(Uri.parse('$apiUrl/products'));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Product> products = body.map((dynamic item) => Product.fromJson(item)).toList();
      return products;
    } else {
      throw "Failed to load product list";
    }
  }

  Future<Product> getProductById(int id) async {
    final idString = id.toString();
    final response = await get(Uri.parse('$apiUrl/products/$idString'));

    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<Product> createProduct(Product product) async {
    Map data = {'name': product.name, 'description': product.description};

    final Response response = await post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post product edits');
    }
  }

  Future<Product> updateProduct(String id, Product product) async {
    Map data = {'name': product.name, 'description': product.description};

    final Response response = await put(
      Uri.parse('$apiUrl/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update product');
    }
  }

  Future<void> deleteProduct(String id) async {
    Response res = await delete(Uri.parse('$apiUrl/$id'));

    if (res.statusCode == 200) {
    } else {
      throw "Failed to delete product.";
    }
  }
}
