import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  int _itemCount = 0;
  double _totalPrice = 0.00;

  List<CartItem> get items => _items;
  double get totalPrice => _totalPrice;
  int get itemCount => _itemCount;

  void addItem(CartItem item, double price) {
    final index = _items.indexWhere((i) => i.name == item.name);
    if (index >= 0) {
      final existingItem = _items[index];
      final combinedPrice =
          double.parse(existingItem.priceSum) + double.parse(item.priceSum);
      final combinedQuantity =
          int.parse(existingItem.quantity) + int.parse(item.quantity);

      _items[index] = CartItem(
        name: existingItem.name,
        singlePrice: existingItem.singlePrice,
        quantity: combinedQuantity.toString(),
        priceSum: combinedPrice.toStringAsFixed(2),
        extras: existingItem.extras,
        note: existingItem.note,
      );
    } else {
      _items.add(item);
    }

    _totalPrice += price;
    _itemCount = _items.length;
    notifyListeners();
  }

  void removeItem(CartItem item) {
    final currentPrice = double.parse(item.priceSum);
    _items.remove(item);
    _itemCount -= 1;
    _totalPrice -= currentPrice;
    notifyListeners();
  }

  void updateQuantityOfItem(CartItem item, int number) {
    final newQuantity = int.parse(item.quantity) + number;
    final newPriceSum = double.parse(item.singlePrice) * newQuantity;
    final index = _items.indexWhere((i) => i.name == item.name);
    if (index >= 0) {
      final CartItem newItem = CartItem(
        name: item.name,
        priceSum: newPriceSum.toStringAsFixed(2),
        quantity: newQuantity.toString(),
        singlePrice: item.singlePrice,
        extras: item.extras,
        note: item.note,
      );
      _items[index] = newItem;
    } else {}
    _totalPrice += (number * double.parse(item.singlePrice));
    notifyListeners();
  }

  void removeZeroQuantityItems() {
    _items.removeWhere((item) => int.parse(item.quantity) == 0);
    _itemCount = _items.length;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
