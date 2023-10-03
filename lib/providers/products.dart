import 'package:flutter/material.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  final List<Product> _list = [
    Product(
      id: "id1",
      title: "Iphone 15",
      description: "description",
      price: 12000,
      imageUrl:
          "https://images.unsplash.com/photo-1695578130338-d517e0020d1a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
    ),
    Product(
      id: "id2",
      title: "MacBook pro 13",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://images.unsplash.com/photo-1611186871348-b1ce696e52c9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
    ),
    Product(
      id: "id3",
      title: "IWatch",
      description: "description",
      price: 12000,
      imageUrl:
          "https://images.unsplash.com/photo-1530508943348-b8f606ea2bf2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
    ),
    Product(
      id: "id4",
      title: "IMac",
      description: "description2",
      price: 20000,
      imageUrl:
          "https://images.unsplash.com/photo-1527443154391-507e9dc6c5cc?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
    ),
  ];

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  void addProducts() {
    // list.add(value);
    notifyListeners();
  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
  }
}
