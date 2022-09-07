import 'package:crepes/models/basket_item.dart';
import 'package:crepes/pages/basket_page.dart';
import 'package:crepes/services/basket_service.dart';
import 'package:crepes/services/product_service.dart';
import 'package:crepes/widgets/cart_with_badge.dart';
import 'package:crepes/widgets/generic_app_bar.dart';
import 'package:crepes/widgets/generic_progress_indicator.dart';
import 'package:crepes/widgets/product_card.dart';
import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late List<MenuItem> menuItems;
  bool isLoading = false;
  List<Product>? products;
  List<BasketItem>? basketItems;
  BasketService basketService = BasketService();

  @override
  void initState() {
    super.initState();
    refreshProducts();
  }

  BasketItem? getBasketItem(int productId) {
    final basketItemResult = basketItems?.where((element) => element.productId == productId);
    if (basketItemResult == null || basketItemResult.isEmpty) return null;

    return basketItemResult.first;
  }

  void quantityChanged() {
    setState(() {
      basketItems = basketService.basketItems;
    });
  }

  Future refreshProducts() async {
    setState(() => isLoading = true);

    products = await ProductService().getProducts();

    basketItems = await basketService.getBasketItems();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final int quantityTotal = basketService.getQuantityTotal();

    return Scaffold(
      appBar: GenericAppBar(
        barTitle: 'Crêpes-on-Command',
        item: CartWithBadge(quantityTotal: quantityTotal),
        routePage: BasketPage(quantityChanged: quantityChanged),
      ),
      body: GenericProgressIndicator(isLoading: isLoading, list: products, action: buildProducts),
    );
  }

  Widget buildProducts() => ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: products?.length,
        itemBuilder: (context, index) {
          final product = products?[index];

          return ProductCard(product: product!, basketItem: getBasketItem(product.id), index: index, quantityChanged: quantityChanged);
        },
      );
}
