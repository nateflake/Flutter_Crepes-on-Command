import 'package:crepes/models/product.dart';
import 'package:crepes/widgets/empty_box.dart';
import 'package:crepes/widgets/product_details_card.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final Function quantityChanged;

  const ProductDetailsPage({
    Key? key,
    required this.product,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.product.name),
          actions: const [emptyBox, emptyBox],
        ),
        body: ProductDetailsCard(
          product: widget.product,
          quantityChanged: widget.quantityChanged,
        ),
      );
}
