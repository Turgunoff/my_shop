import 'package:flutter/material.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isloading = true;
      });
      Provider.of<Orders>(context, listen: false).getOrders().then((_) {
        setState(() {
          _isloading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyurtmalar'),
      ),
      drawer: const AppDrawer(),
      body: orders.items.isEmpty
          ? const Center(child: Text('Buyurtmalar mavjud emas'))
          : ListView.builder(
        itemCount: orders.items.length,
        itemBuilder: (ctx, i) {
          final order = orders.items[i];
          return OrderItem(
            totalPrice: order.totalPrice,
            date: order.dateTime,
            products: order.products,
          );
        },
      ),
    );
  }
}
