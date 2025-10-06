import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cafe/utils/constants/colors.dart';
import 'package:cafe/utils/helper/products_page_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final String productsName;
  final String productsPrice;
  final String productsDescription;
  final String productsImage;
  const ProductDetail({
    super.key,
    required this.productsName,
    required this.productsPrice,
    required this.productsDescription,
    required this.productsImage
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductsPageHelper productsPageHelper = ProductsPageHelper();
  final TextEditingController _controller = TextEditingController();
  int currentAmount = 0;
  late CartItem item;

  @override
  void initState() {
    super.initState();
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
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // will be replaced with url from firebase storage
                        Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: ClipOval(
                            child: Image.asset(
                              "lib/assets/pictures/${widget.productsImage}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 100),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.productsName,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              SizedBox(height: 5),
                              Text(
                                '€ ${widget.productsPrice}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(height: 30),
                              Align(
                                alignment: AlignmentGeometry.center,
                                child: Text(
                                  widget.productsDescription,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall,
                                  softWrap: true,
                                ),
                              ),
                            ],
                          ),
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
                          child: Icon(
                            Icons.arrow_back,
                            size: 30,
                            color: Colors.white,
                          ),
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                              SizedBox(width: 20),
                              // quantity
                              Text(
                                '$currentAmount',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              SizedBox(width: 20),
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
                            ],
                          ),
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
                            ),
                          ],
                        ),

                        // add to Card button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromHeight(20),
                            backgroundColor: currentAmount == 0
                                ? Colors.grey
                                : const Color.fromARGB(255, 5, 113, 9),
                          ),
                          onPressed: () async {
                            if (currentAmount != 0) {
                              await productsPageHelper.setTotalProducts(
                                currentAmount,
                              );
                              double price =
                                  currentAmount *
                                  double.parse(widget.productsPrice);
                              await productsPageHelper.setTotalPrice(price);
                              item = CartItem(
                                name: widget.productsName,
                                singlePrice: widget.productsPrice,
                                priceSum: price.toStringAsFixed(2),
                                quantity: currentAmount.toString(),
                                note: _controller.text,
                                extras: [],
                              );
                              Provider.of<CartProvider>(
                                context,
                                listen: false,
                              ).addItem(item, price);
                              Navigator.pop(context);
                            }
                          },
                          child: Text('Hinzufügen'),
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
