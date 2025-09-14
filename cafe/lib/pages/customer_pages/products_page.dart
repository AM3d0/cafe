import 'package:cafe/backend/services/products_service.dart';
import 'package:cafe/pages/customer_pages/product_visualization.dart';
import 'package:cafe/utils/helper/products_page_helper.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  final ProductsPageHelper productsPageHelper = ProductsPageHelper();
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsService productsService = ProductsService();
  ProductsPageHelper productsPageHelper = ProductsPageHelper();
  // List<Map<String, dynamic>> products = [];
  late List<Map<String, dynamic>> hotDrinks;
  late List<Map<String, dynamic>> coldDrinks;
  late List<Map<String, dynamic>> cakes;
  // List<String> categories = [];

  @override
  void initState() {
    super.initState();
    cakes = productsPageHelper.getCertainProductsPrefs("Cake");
    coldDrinks = productsPageHelper.getCertainProductsPrefs("Cold Drinks");
    hotDrinks = productsPageHelper.getCertainProductsPrefs("Hot Drinks");
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await productsService.getAllProducts();
    final loadedHotDrinks = await productsService.getAllProductsOfCategory(
      'Hot Drinks',
    );
    final loadedCakes = await productsService.getAllProductsOfCategory('Cake');
    final loadedColdDrinks = await productsService.getAllProductsOfCategory(
      'Cold Drinks',
    );
    final uniqueCategories = loadedProducts
        .map((p) => p["category"].toString())
        .toSet()
        .toList();

    if (cakes != loadedCakes) {
      productsPageHelper.setCertainProductsPrefs('Cake', loadedCakes);
      setState(() {
        cakes = loadedCakes;
      });
    }
    if (hotDrinks != loadedHotDrinks) {
      productsPageHelper.setCertainProductsPrefs('Hot Drinks', loadedHotDrinks);
      setState(() {
        hotDrinks = loadedHotDrinks;
      });
    }
    if (coldDrinks != loadedColdDrinks) {
      productsPageHelper.setCertainProductsPrefs('Cold Drinks', loadedColdDrinks);
      setState(() {
        coldDrinks = loadedColdDrinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
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
