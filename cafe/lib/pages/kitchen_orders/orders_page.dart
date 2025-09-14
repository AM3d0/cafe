import 'package:cafe/backend/services/products_service.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  ProductsService productsService = ProductsService();
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
