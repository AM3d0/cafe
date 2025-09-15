import 'package:cafe/pages/customer_pages/product_detail.dart';
import 'package:cafe/utils/constants/colors.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CarouselView.weighted(
        scrollDirection: Axis.horizontal,
        backgroundColor: Color(0xFF2f4538),
        flexWeights: [1, 1],
        shrinkExtent: 300,
        enableSplash: true,
        onTap: (index) {
          final product = widget.products[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetail(
                productsName: product['name'],
                productsPrice: product['price'].toString(),
              ),
            ),
          );
        },
        children: widget.products.map((product) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(40),
              side: BorderSide(color: Colors.white)
            ),
            
            color: CColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product['name'],
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Text(
                    '${product['price']} €',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${product['description']}',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
