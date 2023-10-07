import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/edit_product_screen.dart';
import 'package:my_shop/widgets/app_drawer.dart';
import 'package:my_shop/widgets/user_product_item.dart';
import 'package:provider/provider.dart';

class ManageProductScreen extends StatelessWidget {
  const ManageProductScreen({super.key});

  static const routeName = '/manage-products';

  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Maxsulotlarni boshqarish'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: productProvider.list.length,
          itemBuilder: (ctx, i) {
            final product = productProvider.list[i];
            return ChangeNotifierProvider.value(
              value: product,
              child: const UserProductItem(),
            );
          },
        ),
      ),
    );
  }
}
