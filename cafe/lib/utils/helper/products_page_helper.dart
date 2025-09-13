import 'package:cafe/backend/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
}
