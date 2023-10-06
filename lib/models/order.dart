import 'cart_item.dart';

class Order {
  final String id;
  final double totalPrice;
  final DateTime dateTime;
  final List<CartItem> products;

  Order({
    required this.id,
    required this.totalPrice,
    required this.dateTime,
    required this.products,
  });
}
