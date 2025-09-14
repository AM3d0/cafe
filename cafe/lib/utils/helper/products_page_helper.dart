import 'package:cafe/backend/services/shared_preferences_service.dart';
import 'dart:convert';

class ProductsPageHelper {
  final prefs = SharedPreferencesService.instance.prefsWithCache;
  List<Map<String, dynamic>> getCertainProductsPrefs(String category) {
    final jsonString = prefs.getString(category);

    if (jsonString == null) return [];

    final List<dynamic> decoded = jsonDecode(jsonString);

    return decoded.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  Future<void> setCertainProductsPrefs(
    String category,
    List<Map<String, dynamic>> products,
  ) async {
    final jsonString = jsonEncode(products);
    await prefs.setString(category, jsonString);
  }

  int getTotalProductsInGrocery() {
    final totalProducts = (prefs.get('Total Products') as int?) ?? 0;
    return totalProducts;
  }

  Future<void> setTotalProducts(int amount) async {
    int totalProducts = (prefs.get('Total Products') as int?) ?? 0;
    totalProducts += amount;
    await prefs.setInt('Total Products', totalProducts);
  }

  double getTotalPrice(){
    final totalPrice = (prefs.getDouble('Total Price')) ?? 0.00;
    return totalPrice;
  }

  Future<void> setTotalPrice(double amount) async {
    double totalPrice = (prefs.getDouble('Total Price')) ?? 0.00;
    totalPrice += amount;
    await prefs.setDouble('Total Price', totalPrice);
  }
}
