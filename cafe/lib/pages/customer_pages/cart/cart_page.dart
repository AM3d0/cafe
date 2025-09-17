import 'package:cafe/backend/services/orders_service.dart';
import 'package:cafe/components/alert_dialog.dart';
import 'package:cafe/pages/customer_pages/cart/cart_item_list.dart';
import 'package:cafe/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  OrdersService ordersService = OrdersService();
  final ScrollController _controller = ScrollController();
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final cartItems = Provider.of<CartProvider>(context).items;
    if (cartItems.isEmpty) {
      return Scaffold(
        backgroundColor: CColors.secondary,
        body: SafeArea(
          child: Center(
            child: SizedBox(
              height: 400,
              width: 600,
              child: Card(
                color: CColors.primary,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Keine Bestellungen',
                        style: TextStyle(color: Colors.white, fontSize: 50),
                      ),
                      Icon(Icons.remove_shopping_cart_outlined, size: 100, color: Colors.white),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 50,
                            ),
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
    return Scaffold(
      backgroundColor: CColors.secondary,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Deine Bestellung',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(height: 25),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  color: CColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5),
                    side: BorderSide(color: Colors.white),
                  ),
                  child: Container(
                    width: double.infinity,
                    constraints: BoxConstraints(minHeight: 500, maxHeight: 500),
                    child: Expanded(
                      child: RawScrollbar(
                        trackVisibility: true,
                        thumbVisibility: true,
                        radius: Radius.circular(10),
                        thickness: 8,
                        thumbColor: Colors.white,

                        controller: _controller,
                        child: SingleChildScrollView(
                          controller: _controller,
                          child: DataTable(
                            border: TableBorder(
                              horizontalInside: BorderSide(color: Colors.white),
                            ),
                            columns: [
                              DataColumn(
                                label: Text(
                                  'Name',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Stückpreis',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Menge',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Info',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Preis',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              DataColumn(
                                label: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      edit = !edit;
                                    });
                                  },
                                  child: Icon(Icons.edit, color: Colors.white),
                                ),
                              ),
                            ],
                            rows:
                                cartItems.map((item) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(item.name)),
                                      DataCell(Text('€ ${item.singlePrice}')),
                                      DataCell(
                                        Row(
                                          children: [
                                            Text(item.quantity.toString()),
                                            SizedBox(width: 10),
                                            edit
                                                ? Column(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            Provider.of<
                                                                  CartProvider
                                                                >(
                                                                  context,
                                                                  listen: false,
                                                                )
                                                                .updateQuantityOfItem(
                                                                  item,
                                                                  1,
                                                                );
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_drop_up,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (int.parse(
                                                                item.quantity,
                                                              ) !=
                                                              0) {
                                                            setState(() {
                                                              Provider.of<
                                                                    CartProvider
                                                                  >(
                                                                    context,
                                                                    listen:
                                                                        false,
                                                                  )
                                                                  .updateQuantityOfItem(
                                                                    item,
                                                                    -1,
                                                                  );
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.arrow_drop_down,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Text(''),
                                          ],
                                        ),
                                      ),
                                      DataCell(
                                        item.note!.isNotEmpty ?
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  InfoAboutDialog(
                                                    extras: [
                                                      'Extra 1',
                                                      'Extra 2',
                                                      'Extra 3',
                                                      'Extra 4',
                                                    ], note: item.note ?? ''
                                                  ),
                                            );
                                          },
                                          child: Icon(
                                            Icons.info,
                                            color: Colors.white,
                                          ),
                                        ) : Text(''),
                                      ),
                                      DataCell(
                                        Text('€ ${item.priceSum.toString()}'),
                                      ),
                                      DataCell(
                                        edit
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    Provider.of<CartProvider>(
                                                      context,
                                                      listen: false,
                                                    ).removeItem(item);
                                                  });
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.white,
                                                ),
                                              )
                                            : Text(''),
                                      ),
                                    ],
                                  );
                                }).toList() +
                                [
                                  DataRow(
                                    cells: [
                                      DataCell(Text('Gesamtbetrag')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(Text('')),
                                      DataCell(
                                        Text(
                                          '€ ${context.watch<CartProvider>().totalPrice.toStringAsFixed(2)}',
                                        ),
                                      ),
                                      DataCell(Text('')),
                                    ],
                                  ),
                                ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: CColors.primary,
                      size: 30,
                    ),
                  ),
                  if (edit)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).clear();
                          edit = !edit;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(60),
                      ),
                      child: Text(
                        'Bestellung löschen',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  if (edit)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Provider.of<CartProvider>(
                            context,
                            listen: false,
                          ).removeZeroQuantityItems();
                          edit = !edit;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(60),
                      ),
                      child: Text('Änderungen vornehmen'),
                    ),
                  ElevatedButton(
                    onPressed: () {
                      if (cartItems.isNotEmpty) {
                        int tableId = Provider.of<CartProvider>(
                          context,
                          listen: false,
                        ).table;
                        ordersService.sendOrder(cartItems, tableId);
                        Navigator.pushNamed(context, '/tablePage');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(60),
                    ),
                    child: Text('Bestellung aufgeben'),
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
