import 'package:crepes/models/basket_item.dart';
import 'package:crepes/pages/checkout_page.dart';
import 'package:crepes/services/basket_service.dart';
import 'package:crepes/widgets/basket_item_card.dart';
import 'package:crepes/widgets/generic_app_bar.dart';
import 'package:crepes/widgets/generic_progress_indicator.dart';
import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  final Function quantityChanged;

  const BasketPage({
    Key? key,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  final BasketService basketService = BasketService();
  List<BasketItem> basketItems = [];
  late List<MenuItem> menuItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    basketItems = basketService.basketItems;
  }

  void updateBasketItems() {
    setState(() {
      basketItems = basketService.basketItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        barTitle: 'Cart',
        item: Icon(Icons.credit_card),
        routePage: CheckoutPage(),
      ),
      body: GenericProgressIndicator(isLoading: isLoading, list: basketItems, action: buildBasketItems),
    );
  }

  Widget buildBasketItems() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: basketItems.length,
        itemBuilder: (context, index) {
          final basketItem = basketItems[index];

          return BasketItemCard(
            basketItem: basketItem,
            index: index,
            updateBasketItems: updateBasketItems,
            quantityChanged: widget.quantityChanged,
          );
        },
      );
}
