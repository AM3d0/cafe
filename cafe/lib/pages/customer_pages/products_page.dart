import 'package:cafe/backend/services/products_service.dart';
import 'package:cafe/pages/customer_pages/product_visualization.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsService productsService = ProductsService();
  List<Map<String, dynamic>> products = [];
  List<Map<String, dynamic>> hotDrinks = [];
  List<Map<String, dynamic>> coldDrinks = [];
  List<Map<String, dynamic>> cakes = [];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await productsService.getAllProducts();
    final loadedHotDrinks = await productsService.getAllProductsOfCategory('Hot Drinks');
    final loadedCakes = await productsService.getAllProductsOfCategory('Cake');
    final loadedColdDrinks = await productsService.getAllProductsOfCategory('Cold Drinks');
    final uniqueCategories = loadedProducts
        .map((p) => p["category"].toString())
        .toSet()
        .toList();
    setState(() {
      products = loadedProducts;
      categories = uniqueCategories;
      hotDrinks = loadedHotDrinks;
      cakes = loadedCakes;
      coldDrinks = loadedColdDrinks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: products.length,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: 'Cake'),
                  Tab(text: 'Hot Drinks'),
                  Tab(text: 'Cold Drinks'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Products(products: cakes),
                    Products(products: hotDrinks),
                    Products(products: coldDrinks),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
