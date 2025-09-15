import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cafe/utils/constants/colors.dart';
import 'package:cafe/utils/helper/products_page_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String productsName;
  final String productsPrice;
  const ProductDetail({
    super.key,
    required this.productsName,
    required this.productsPrice,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductsPageHelper productsPageHelper = ProductsPageHelper();
  final TextEditingController _controller = TextEditingController();
  int currentAmount = 0;
  late int totalProducts;
  late double totalPrice;
  late CartItem item;

  @override
  void initState() {
    super.initState();
    _loadNumberOfTotalProducts();
    _loadTotalPrice();
  }

  void _loadNumberOfTotalProducts() {
    totalProducts = productsPageHelper.getTotalProductsInGrocery();
  }

  void _loadTotalPrice() {
    totalPrice = productsPageHelper.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColors.secondary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            color: CColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
              side: BorderSide(color: Colors.white),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.productsName,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.productsPrice,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // go back (pop off)
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back, size: 30, color: Colors.white),
                        ),
                        // Extra information textbox
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _controller,
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: 'Do you want to add a note ?',
                              labelStyle: TextStyle(color: Colors.white),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              
                            ),
                          ),
                        ),

                        // minus icon
                        GestureDetector(
                          onTap: () {
                            if (currentAmount != 0) {
                              setState(() {
                                currentAmount -= 1;
                              });
                            }
                          },
                          child: Icon(Icons.remove, color: Colors.white),
                        ),
                        // quantity
                        Text('$currentAmount'),
                        // plus icon
                        GestureDetector(
                          onTap: () {
                            if (currentAmount != 10) {
                              setState(() {
                                currentAmount += 1;
                              });
                            }
                          },
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                        // Grocery Icon with Products Count
                        Column(
                          children: [
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
                                      color: CColors.secondary,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 20,
                                      minHeight: 20,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '$totalProducts',
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
                            Text('Total €${totalPrice.toStringAsFixed(2)}'),
                          ],
                        ),

                        // add to Card button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(20),
                            backgroundColor: currentAmount == 0
                                ? Colors.grey
                                : Colors.blue,
                          ),
                          onPressed: () async {
                            if (currentAmount != 0) {
                              Navigator.pop(context);
                              await productsPageHelper.setTotalProducts(
                                currentAmount,
                              );
                              double price =
                                  currentAmount *
                                  double.parse(widget.productsPrice);
                              await productsPageHelper.setTotalPrice(price);
                              item = CartItem(
                                name: widget.productsName,
                                priceSum: price.toString(),
                                quantity: currentAmount.toString(),
                                note: _controller.text,
                              );
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addItem(item, price);
                            }
                          },
                          child: Text('add'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
