import 'package:flutter/material.dart';
import 'package:my_shop/providers/products.dart';
import 'package:my_shop/screens/home_screen.dart';
import 'package:my_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Products>(
      create: (context) {
        return Products();
      },
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.teal,
            fontFamily: 'Lato',
          ),
          debugShowCheckedModeBanner: false,
          home: const HomeScreen(),
          routes: {
            ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          }),
    );
  }
}
