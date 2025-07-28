import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class Order {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  final String status;
  final String address;
  final String paymentMethod;

  Order({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
    this.status = 'Processing',
    required this.address,
    required this.paymentMethod,
  });
}
