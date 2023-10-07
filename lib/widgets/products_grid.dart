import 'package:flutter/material.dart';
import 'package:my_shop/widgets/product_item.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';

class ProductsGrid extends StatefulWidget {
  final bool showFavorites;

  const ProductsGrid(
    this.showFavorites, {
    super.key,
  });

  @override
  State<ProductsGrid> createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  var _init = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .getProducts()
          .then((response) {
        _isLoading = false;
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products =
        widget.showFavorites ? productsData.favorites : productsData.list;
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : products.isNotEmpty
            ? GridView.builder(
                padding: const EdgeInsets.all(20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                ),
                itemCount: products.length,
                itemBuilder: (ctx, i) {
                  return ChangeNotifierProvider<Product>.value(
                    value: products[i],
                    child: const ProductItem(),
                  );
                },
              )
            : const Center(
                child: Text('Maxsulotlar mavjud emas!'),
              );
  }
}
