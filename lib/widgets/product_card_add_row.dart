import 'package:crepes/models/basket_item.dart';
import 'package:crepes/services/basket_service.dart';
import 'package:flutter/material.dart';

var basketService = BasketService();

class ProductCardAddRow extends StatelessWidget {
  final int productId;
  final String productName;
  final BasketItem? basketItem;
  final Function quantityChanged;

  const ProductCardAddRow({
    Key? key,
    required this.productId,
    required this.productName,
    required this.basketItem,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 50.0,
          decoration: const BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
            ),
          ),
          alignment: Alignment.topRight,
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () {
              basketService.updateProductQuantityInBasket(productId, 1);
              quantityChanged();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 500),
                content: Text('$productName added to cart'),
              ));
            },
            child: const Icon(
              Icons.add,
              size: 24.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
