import 'package:cafe/utils/helper/products_page_helper.dart';
import 'package:flutter/material.dart';

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(widget.productsName)],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(widget.productsPrice)],
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
                        child: Icon(Icons.arrow_back, size: 30),
                      ),
                      // Extra information textbox
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            labelText: 'Do you want to add a note ?',
                            border: OutlineInputBorder(),
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
                        child: Icon(Icons.remove),
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
                        child: Icon(Icons.add),
                      ),
                      // Grocery Icon with Products Count
                      Column(
                        children: [
                          Stack(
                            children: [
                              Icon(
                                Icons.shopping_bag,
                                size: 40,
                                color: Colors.grey,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                      255,
                                      207,
                                      201,
                                      201,
                                    ),
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
                          Text('Total €${totalPrice.toStringAsFixed(2)}'),
                        ],
                      ),
                      // amount of costs

                      // add to Card button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
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
    );
  }
}
