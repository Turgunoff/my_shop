import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  void addToOrders(List<CartItem> products, double totalPrice) {
    _items.insert(
      0,
      Order(
        id: UniqueKey().toString(),
        totalPrice: totalPrice,
        dateTime: DateTime.now(),
        products: products,
      ),
    );
    notifyListeners();
  }
}
