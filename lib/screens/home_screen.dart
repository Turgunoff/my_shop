import 'package:flutter/material.dart';

import '../models/product.dart';
import '../widgets/product_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Product> _products = [
    Product(
      id: "id1",
      title: "title",
      description: "description",
      price: 12000,
      imageUrl:
          "https://www.cnet.com/a/img/resize/5f624f7c63102565c447663f085e95d00cb36953/hub/2015/04/07/b35f1174-696c-4d25-8a4f-fa16a2842338/macbook-air-gold-2015-16.jpg?auto=webp&fit=crop&height=675&width=1200",
    ),
    Product(
      id: "id2",
      title: "title2",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://techcrunch.com/wp-content/uploads/2022/09/Apple-iphone-14-Pro-review-1.jpeg?w=730&crop=1",
    ),
    Product(
      id: "id1",
      title: "title",
      description: "description",
      price: 12000,
      imageUrl:
          "https://www.cnet.com/a/img/resize/5f624f7c63102565c447663f085e95d00cb36953/hub/2015/04/07/b35f1174-696c-4d25-8a4f-fa16a2842338/macbook-air-gold-2015-16.jpg?auto=webp&fit=crop&height=675&width=1200",
    ),
    Product(
      id: "id2",
      title: "title2",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://techcrunch.com/wp-content/uploads/2022/09/Apple-iphone-14-Pro-review-1.jpeg?w=730&crop=1",
    ),
    Product(
      id: "id1",
      title: "title",
      description: "description",
      price: 12000,
      imageUrl:
          "https://www.cnet.com/a/img/resize/5f624f7c63102565c447663f085e95d00cb36953/hub/2015/04/07/b35f1174-696c-4d25-8a4f-fa16a2842338/macbook-air-gold-2015-16.jpg?auto=webp&fit=crop&height=675&width=1200",
    ),
    Product(
      id: "id2",
      title: "title2",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://techcrunch.com/wp-content/uploads/2022/09/Apple-iphone-14-Pro-review-1.jpeg?w=730&crop=1",
    ),
    Product(
      id: "id1",
      title: "title",
      description: "description",
      price: 12000,
      imageUrl:
          "https://www.cnet.com/a/img/resize/5f624f7c63102565c447663f085e95d00cb36953/hub/2015/04/07/b35f1174-696c-4d25-8a4f-fa16a2842338/macbook-air-gold-2015-16.jpg?auto=webp&fit=crop&height=675&width=1200",
    ),
    Product(
      id: "id2",
      title: "title2",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://techcrunch.com/wp-content/uploads/2022/09/Apple-iphone-14-Pro-review-1.jpeg?w=730&crop=1",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My shop"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemCount: _products.length,
        itemBuilder: (ctx, i) {
          return ProductItem(
            image: _products[i].imageUrl,
            title: _products[i].title,
          );
        },
      ),
    );
  }
}
