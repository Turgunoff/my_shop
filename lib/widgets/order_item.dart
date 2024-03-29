import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_shop/models/cart_item.dart';

class OrderItem extends StatefulWidget {
  final double totalPrice;
  final DateTime date;
  final List<CartItem> products;

  const OrderItem({
    super.key,
    required this.totalPrice,
    required this.date,
    required this.products,
  });

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expandItem = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.totalPrice}'),
            subtitle: Text(DateFormat('dd/MM/yyyy hh:mm').format(widget.date)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  _expandItem = !_expandItem;
                });
              },
              icon: Icon(_expandItem ? Icons.expand_less : Icons.expand_more),
              splashRadius: 20,
            ),
          ),
          if (_expandItem)
            Container(
              padding: const EdgeInsets.all(5),
              height: min(widget.products.length * 20 + 50, 150),
              child: ListView.builder(
                itemExtent: 20,
                itemCount: widget.products.length,
                itemBuilder: (ctx, i) {
                  final product = widget.products[i];
                  return ListTile(
                    title: Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      '${product.quantity}x \$${product.price}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}
