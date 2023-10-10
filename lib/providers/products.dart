import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_shop/services/http_exception.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _list = [];

  String? _authToken;

  void setParams(String authToken) {
    _authToken = authToken;
  }

  List<Product> get list {
    return [..._list];
  }

  List<Product> get favorites {
    return _list.where((product) => product.isFavorite).toList();
  }

  Future<void> getProducts() async {
    final url = Uri.parse(
        'https://fir-app-91c1f-default-rtdb.firebaseio.com/products.json?auth=$_authToken');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<Product> loadedProducts = [];
        data.forEach((productId, productData) {
          loadedProducts.add(Product(
            id: productId,
            title: productData['title'] as String,
            description: productData['description'] as String,
            price: productData['price'] as double,
            // Assuming price is a double, adjust if needed
            imageUrl: productData['imageUrl'] as String,
            isFavorite: productData['isFavorite'] as bool,
          ));
        });
        _list = loadedProducts;
        notifyListeners();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://fir-app-91c1f-default-rtdb.firebaseio.com/products.json?auth=$_authToken');

    try {
      final response = await http.post(url,
          body: jsonEncode(
            {
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite,
            },
          ));
      final name = (json.decode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = Product(
        id: name,
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      list.add(newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product updateProduct) async {
    final productIndex =
        _list.indexWhere((product) => product.id == updateProduct.id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://fir-app-91c1f-default-rtdb.firebaseio.com/products/${updateProduct.id}.json?auth=$_authToken');

      try {
        await http.patch(
          url,
          body: jsonEncode(
            {
              'title': updateProduct.title,
              'description': updateProduct.description,
              'price': updateProduct.price,
              'imageUrl': updateProduct.imageUrl,
            },
          ),
        );
        _list[productIndex] = updateProduct;
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  Product findById(String productId) {
    return _list.firstWhere((product) => product.id == productId);
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://fir-app-91c1f-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken');
    try {
      var deletingProduct = _list.firstWhere((product) => product.id == id);
      final productIndex = _list.indexWhere((product) => product.id == id);
      _list.removeWhere((product) => product.id == id);
      notifyListeners();

      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpException('O\'chirishda xatolik');
      }
    } catch (error) {
      rethrow;
    }
  }
}
