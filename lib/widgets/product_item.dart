import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String image;
  final String title;
  const ProductItem({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite_outline,
              color: Theme.of(context).primaryColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_rounded,
              color: Theme.of(context).primaryColor,
            ),
          ),
          backgroundColor: const Color.fromARGB(190, 0, 0, 0),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
