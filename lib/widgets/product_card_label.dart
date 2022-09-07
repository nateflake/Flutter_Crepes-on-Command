import 'package:crepes/models/product.dart';
import 'package:crepes/pages/product_details.dart';
import 'package:flutter/material.dart';

class ProductCardLabel extends StatelessWidget {
  final Product product;
  final Function quantityChanged;

  const ProductCardLabel({
    Key? key,
    required this.product,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product, quantityChanged: quantityChanged),
        ));
      },
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(color: Colors.black12),
        child: Text(
          product.name,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
