import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  double _totalPrice = 0.00;

  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;

  void addItem(CartItem item, double price) {
    _items.add(item);
    _totalPrice += price;
    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
