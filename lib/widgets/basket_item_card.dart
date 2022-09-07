import 'package:crepes/models/basket_item.dart';
import 'package:crepes/services/basket_service.dart';
import 'package:crepes/services/global_service.dart';
import 'package:flutter/material.dart';

class BasketItemCard extends StatefulWidget {
  final BasketItem basketItem;
  final int index;
  final Function updateBasketItems;
  final Function quantityChanged;

  //final Function refreshBasket;

  const BasketItemCard({
    Key? key,
    required this.basketItem,
    required this.index,
    required this.updateBasketItems,
    required this.quantityChanged,
  }) : super(key: key);

  @override
  State<BasketItemCard> createState() => _BasketItemCardState();
}

class _BasketItemCardState extends State<BasketItemCard> {
  late List<MenuItem> menuItems;
  bool isLoading = false;

  int _priceInt = 0;
  String _price = '';
  String _total = '';
  int _quantityInt = 0;
  String _quantity = '';

  @override
  void initState() {
    super.initState();
    _priceInt = widget.basketItem.price;
    _price = formatDollars(widget.basketItem.price);
    _total = formatDollars(getTotalPrice(widget.basketItem.quantity, widget.basketItem.price));
    _quantityInt = widget.basketItem.quantity;
    _quantity = widget.basketItem.quantity.toString();
  }

  var globalService = GlobalService();
  var basketService = BasketService();
  List<dynamic>? basketItems;

  incrementQuantity(int oldQuantityInt) {
    setState(() {
      _quantityInt = oldQuantityInt + 1;
      _quantity = _quantityInt.toString();
      _total = formatDollars(getTotalPrice(_quantityInt, _priceInt));
    });
  }

  decrementQuantity(int oldQuantityInt) {
    setState(() {
      _quantityInt = oldQuantityInt - 1;
      _quantity = _quantityInt.toString();
      _total = formatDollars(getTotalPrice(_quantityInt, _priceInt));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 175,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(globalService.getImage(widget.basketItem.pictureUrl)),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.all(12),
                      child: const SizedBox(width: 0),
                    ),
                  ),
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
                                widget.basketItem.name,
                                style: const TextStyle(fontSize: 22.0),
                              ),
                            ),
                          ),
                          Text(
                            'brand: ${widget.basketItem.brand}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'type: ${widget.basketItem.type}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                          Text(
                            'price: $_price',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'total: $_total',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          if (await basketService.deleteBasketItem(widget.basketItem.productId) == 1) {
                            widget.quantityChanged();
                            widget.updateBasketItems();
                          }
                        },
                        icon: const Icon(Icons.delete_outline, size: 16.0),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_quantityInt > 1) {
                            basketService.updateProductQuantityInBasket(widget.basketItem.productId, -1);
                            widget.quantityChanged();
                            decrementQuantity(_quantityInt);
                          }
                        },
                        icon: Icon(
                          Icons.remove,
                          color: _quantityInt == 1 ? Colors.grey[500] : Colors.black87,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                        child: Center(
                          child: Text(_quantity),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          basketService.updateProductQuantityInBasket(widget.basketItem.productId, 1);
                          widget.quantityChanged();
                          incrementQuantity(_quantityInt);
                        },
                        icon: const Icon(Icons.add),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
