import 'package:cafe/backend/services/products_service.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cafe/pages/customer_pages/product_visualization.dart';
import 'package:cafe/utils/constants/colors.dart';
import 'package:cafe/utils/helper/products_page_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsPage extends StatefulWidget {
  final ProductsPageHelper productsPageHelper = ProductsPageHelper();
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  ProductsService productsService = ProductsService();
  ProductsPageHelper productsPageHelper = ProductsPageHelper();
  late List<Map<String, dynamic>> hotDrinks;
  late List<Map<String, dynamic>> coldDrinks;
  late List<Map<String, dynamic>> cakes;

  @override
  void initState() {
    super.initState();
    cakes = productsPageHelper.getCertainProductsPrefs("Cake");
    coldDrinks = productsPageHelper.getCertainProductsPrefs("Cold Drinks");
    hotDrinks = productsPageHelper.getCertainProductsPrefs("Hot Drinks");
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    // final loadedProducts = await productsService.getAllProducts();
    final loadedHotDrinks = await productsService.getAllProductsOfCategory(
      'Hot Drinks',
    );
    final loadedCakes = await productsService.getAllProductsOfCategory('Cake');
    final loadedColdDrinks = await productsService.getAllProductsOfCategory(
      'Cold Drinks',
    );

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
      productsPageHelper.setCertainProductsPrefs(
        'Cold Drinks',
        loadedColdDrinks,
      );
      setState(() {
        coldDrinks = loadedColdDrinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2f4538),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      indicatorColor: CColors.primary,
                      labelColor: CColors.primary,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(icon: Icon(Icons.cake), text: 'Cakes'),
                        Tab(icon: Icon(Icons.local_cafe), text: 'Hot Drinks'),
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
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      // Shopping Icon with number of total products and total price
                      Stack(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 40,
                            color: Colors.white,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: CColors.primary,
                                shape: BoxShape.circle,
                              ),
                              constraints: BoxConstraints(
                                minWidth: 20,
                                minHeight: 20,
                              ),
                              child: Center(
                                child: Text(
                                  '${context.watch<CartProvider>().itemCount}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      // amount of costs
                      Text(
                        'Total €${context.watch<CartProvider>().totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  // Button to go to the order
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/customerOrders');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(40),
                    ),
                    child: Text('zum Warenkorb'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
