import 'package:crepes/models/basket_item.dart';
import 'package:crepes/models/product.dart';
import 'package:crepes/services/global_service.dart';
import 'package:crepes/widgets/product_card_add_row.dart';
import 'package:crepes/widgets/product_card_label.dart';
import 'package:flutter/material.dart';

var globalService = GlobalService();

class ProductCard extends StatelessWidget {
  final Product product;
  final BasketItem? basketItem;
  final int index;
  final Function quantityChanged;

  const ProductCard({
    Key? key,
    required this.product,
    required this.basketItem,
    required this.index,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(globalService.getImage(product.pictureUrl)),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProductCardAddRow(productId: product.id, productName: product.name, basketItem: basketItem, quantityChanged: quantityChanged),
              ProductCardLabel(
                product: product,
                quantityChanged: quantityChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
