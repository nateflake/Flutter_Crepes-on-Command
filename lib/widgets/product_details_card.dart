import 'package:crepes/models/basket_item.dart';
import 'package:crepes/models/product.dart';
import 'package:crepes/services/basket_service.dart';
import 'package:crepes/services/global_service.dart';
import 'package:flutter/material.dart';

class ProductDetailsCard extends StatefulWidget {
  final Product product;
  final Function quantityChanged;

  const ProductDetailsCard({
    Key? key,
    required this.product,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  final BasketService basketService = BasketService();
  var globalService = GlobalService();

  late List<MenuItem> menuItems;
  bool isLoading = false;

  late Future<BasketItem?> _basketItem;
  int _quantityInt = 0;

  @override
  void initState() {
    super.initState();
    _basketItem = getBasketItem();
    _quantityInt = basketService.getQuantity(widget.product.id);
  }

  Future<BasketItem?> getBasketItem() {
    return basketService.getBasketItemById(widget.product.id);
  }

  incrementQuantity(int oldQuantityInt) {
    setState(() {
      _quantityInt = oldQuantityInt + 1;
    });
  }

  decrementQuantity(int oldQuantityInt) {
    setState(() {
      _quantityInt = oldQuantityInt - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error} occurred',
                style: const TextStyle(fontSize: 18),
              ),
            );
          }

          return Card(
            elevation: 0,
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 575,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Container(
                            width: double.infinity,
                            height: 250.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(globalService.getImage(widget.product.pictureUrl)),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.all(12),
                            child: const SizedBox(width: 0),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 54.0,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.name,
                                      style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 54.0,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.product.description,
                                      style: const TextStyle(fontSize: 18.0, fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Text(
                                      'brand: ',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      widget.product.brand,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  children: [
                                    const Text(
                                      'type: ',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      widget.product.type,
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 1),
                                Row(
                                  children: [
                                    const Text(
                                      'price: ',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                                    ),
                                    Text(
                                      formatDollars(widget.product.price),
                                      style: const TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _quantityInt > 0
                            ? const Text(
                                'Cart:',
                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                              )
                            : const Text(''),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _quantityInt > 0
                            ? RawMaterialButton(
                                elevation: 2.0,
                                fillColor: _quantityInt > 0 ? Colors.red : Colors.grey[300],
                                padding: const EdgeInsets.all(4.0),
                                shape: const CircleBorder(),
                                onPressed: () async {
                                  var deleted = await basketService.deleteBasketItem(widget.product.id);
                                  if (deleted == 1) {
                                    widget.quantityChanged();
                                    setState(() {
                                      _quantityInt = 0;
                                    });
                                  }
                                },
                                child: Icon(
                                  Icons.delete_outline,
                                  size: 22.0,
                                  color: _quantityInt > 0 ? Colors.white : Colors.grey[500],
                                ),
                              )
                            : const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(
                                  'Add to Cart:',
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                                ),
                              ),
                        _quantityInt > 0
                            ? ButtonBar(
                                alignment: MainAxisAlignment.end,
                                buttonMinWidth: 70,
                                buttonHeight: 40,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: _quantityInt > 1 ? Colors.black : Colors.grey[300],
                                      foregroundColor: _quantityInt > 1 ? Colors.white : Colors.grey[500],
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          bottomLeft: Radius.circular(25),
                                        ),
                                      ),
                                      elevation: 2,
                                      minimumSize: const Size(20, 30),
                                    ),
                                    onPressed: () {
                                      if (_quantityInt > 1) {
                                        basketService.updateProductQuantityInBasket(widget.product.id, -1);
                                        widget.quantityChanged();
                                        decrementQuantity(_quantityInt);
                                      }
                                    },
                                    child: const Icon(Icons.remove),
                                  ),
                                  SizedBox(
                                    width: 40.0,
                                    child: Center(
                                      child: Text(_quantityInt.toString(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(25),
                                          bottomRight: Radius.circular(25),
                                        ),
                                      ),
                                      elevation: 2,
                                      minimumSize: const Size(20, 30),
                                    ),
                                    onPressed: () {
                                      basketService.updateProductQuantityInBasket(widget.product.id, 1);
                                      widget.quantityChanged();
                                      incrementQuantity(_quantityInt);
                                    },
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    elevation: 2,
                                    minimumSize: const Size(30, 30),
                                  ),
                                  onPressed: () {
                                    basketService.updateProductQuantityInBasket(widget.product.id, 1);
                                    widget.quantityChanged();
                                    incrementQuantity(_quantityInt);
                                  },
                                  child: const Icon(Icons.add),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },

      // Future that needs to be resolved
      // inorder to display something on the Canvas
      future: _basketItem,
    );
  }
}
