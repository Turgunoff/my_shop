import 'package:flutter/material.dart';
import 'package:my_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

enum FiltersOption {
  All,
  Favorites,
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My shop"),
        actions: [
          PopupMenuButton(
            onSelected: (FiltersOption filter) {
              setState(() {
                if (filter == FiltersOption.All) {
                  _showOnlyFavorites = false;
                } else {
                  _showOnlyFavorites = true;
                }
              });
            },
            itemBuilder: (ctx) {
              return [
                const PopupMenuItem(
                  value: FiltersOption.Favorites,
                  child: Text('Sevimli'),
                ),
                const PopupMenuItem(
                  value: FiltersOption.All,
                  child: Text('Barchasi'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
