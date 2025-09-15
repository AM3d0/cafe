import 'package:cafe/backend/services/orders_service.dart';
import 'package:cafe/backend/services/products_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  ProductsService productsService = ProductsService();
  OrdersService ordersService = OrdersService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Küchen-Bestellungen")),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ordersService.listenActiveOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          //   return Center(child: Text("Keine aktiven Bestellungen"));
          // }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bestellung ${order['id']}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...order['items'].map(
                      (item) => Column(
                        children: [
                          Text('${item['productName']} x ${item['quantity']}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
