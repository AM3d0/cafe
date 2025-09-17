import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TablePage extends StatelessWidget {
  TablePage({super.key});
  final tableList = [1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).clear();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            children: tableList.map((table) {
              return ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(
                    context,
                    listen: false,
                  ).setTable(table);
                  Navigator.pushNamed(context, '/customer');
                },
                child: Text('$table', style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
