import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartWithBadge extends ConsumerWidget {
  final int quantityTotal;

  const CartWithBadge({Key? key, required this.quantityTotal}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: -8),
      badgeContent: Text(
        quantityTotal > 0 ? quantityTotal.toString() : '',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      badgeColor: quantityTotal > 0 ? Colors.red : Colors.transparent,
      child: const Icon(Icons.shopping_cart_outlined),
    );
  }
}
