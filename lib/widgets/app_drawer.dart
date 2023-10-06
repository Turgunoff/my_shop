import 'package:flutter/material.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/manage_product_screen.dart';
import 'package:my_shop/screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text('data'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text('Magazin'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(HomeScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Buyurtmalar'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(OrdersScreen.routeName),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Maxsulotlarni boshqarish'),
            onTap: () => Navigator.of(context)
                .pushReplacementNamed(ManageProductScreen.routeName),
          ),
        ],
      ),
    );
  }
}
