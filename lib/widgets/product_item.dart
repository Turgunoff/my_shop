import 'package:flutter/material.dart';
import 'package:my_shop/models/product.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName,
            arguments: product.id,
          );
        },
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (ctx, pro, child) {
                return IconButton(
                  onPressed: () {
                    pro.toggleFavorite();
                  },
                  icon: Icon(
                    pro.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                  ),
                );
              },
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addToCart(
                    product.id, product.title, product.imageUrl, product.price);
              },
              icon: Icon(
                Icons.shopping_cart_rounded,
                color: Theme.of(context).primaryColor,
              ),
            ),
            backgroundColor: const Color.fromARGB(190, 0, 0, 0),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
          ),
          child: Image.network(product.imageUrl, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
