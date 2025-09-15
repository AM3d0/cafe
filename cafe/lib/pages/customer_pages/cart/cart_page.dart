import 'package:cafe/backend/services/orders_service.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  OrdersService ordersService = OrdersService();
  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context, listen: false).items;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  child: ListTile(
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                item.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 200),
                            SizedBox(
                              width: 120,
                              child: Text('Menge: ${item.quantity}'),
                            ),
                            SizedBox(width: 50),
                            SizedBox(
                              width: 120,
                              child: Text('Preis: ${item.priceSum}'),
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            item.extras.isEmpty
                                ? SizedBox.shrink()
                                : SizedBox(
                                    width: 200,
                                    child: Text('Extras: ${item.extras}'),
                                  ),
                            item.note!.isEmpty
                                ? SizedBox.shrink()
                                : SizedBox(
                                    width: 300,
                                    child: Text('Notiz: ${item.note}'),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ordersService.sendOrder(cartItems);
            },
            child: Text('Bestellung aufgeben'),
          ),
        ],
      ),
    );
  }
}
