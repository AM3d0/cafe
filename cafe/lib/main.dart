import 'package:cafe/backend/services/shared_preferences_service.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cafe/pages/customer_pages/cart/cart_page.dart';
import 'package:cafe/pages/customer_pages/products_page.dart';
import 'package:cafe/pages/customer_pages/table_page.dart';
import 'package:cafe/pages/homepage.dart';
import 'package:cafe/pages/kitchen_orders/orders_page.dart';
import 'package:cafe/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesService.instance.initPrefs();
  await SharedPreferencesService.instance.resetPrefsOfGroceryNumber();
  await SharedPreferencesService.instance.resetPrefsOfTotalPrice();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: CAppTheme.cThemeData,
      home: Homepage(),
      routes: {
        '/kitchen': (context) => OrdersPage(),
        '/customer': (context) => ProductsPage(),
        '/customerOrders' : (context) => CartPage(),
        '/tablePage' : (context) => TablePage()
      },
    );
  }
}
