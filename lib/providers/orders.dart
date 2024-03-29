import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_shop/models/cart_item.dart';
import 'package:my_shop/models/order.dart';
import 'package:http/http.dart' as http;

class Orders with ChangeNotifier {
  List<Order> _items = [];

  List<Order> get items {
    return [..._items];
  }

  Future<void> getOrders() async {
    final url = Uri.parse(
        'https://fir-app-91c1f-default-rtdb.firebaseio.com/orders.json');

    try {
      final response = await http.get(url);
      // if (jsonDecode(response.body) == null) {
      //   return;
      // }
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      List<Order> loadedOrders = [];
      data.forEach(
        (orderId, order) {
          loadedOrders.insert(
            0,
            Order(
              id: orderId,
              totalPrice: order['totalPrice'],
              dateTime: DateTime.parse(order['date']),
              products: (order['products'] as List<dynamic>)
                  .map(
                    (product) => CartItem(
                        id: product['id'],
                        title: product['title'],
                        quantity: product['quantity'],
                        price: product['price'],
                        image: product['image']),
                  )
                  .toList(),
            ),
          );
        },
      );
      _items = loadedOrders;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToOrders(List<CartItem> products, double totalPrice) async {
    final url = Uri.parse(
        'https://fir-app-91c1f-default-rtdb.firebaseio.com/orders.json');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'totalPrice': totalPrice,
            'date': DateTime.now().toIso8601String(),
            'products': products
                .map(
                  (product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price,
                    'image': product.image,
                  },
                )
                .toString(),
          },
        ),
      );
      _items.insert(
        0,
        Order(
          id: jsonDecode(response.body)['name'],
          totalPrice: totalPrice,
          dateTime: DateTime.now(),
          products: products,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
