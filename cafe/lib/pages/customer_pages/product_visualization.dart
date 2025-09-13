import 'package:flutter/material.dart';

class Products extends StatefulWidget {
  final List<Map<String, dynamic>> products;
  const Products({super.key, required this.products});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselView.weighted(
        scrollDirection: Axis.horizontal,
        flexWeights: [1,1],
        shrinkExtent: 300,
        children: widget.products.map((product) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Kategorie: ${product['category']}'),
                    Text('Preis: ${product['price']} €'),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
