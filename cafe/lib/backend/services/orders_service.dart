import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersService {

  // function to push an order
  Future<void> sendOrder(List<CartItem> cart) async {
    final order = {
      "items": cart.map((item) => item.toJson()).toList(),
      "timestamp": FieldValue.serverTimestamp(),
      "status": "active", 
    };

    await FirebaseFirestore.instance.collection("orders").add(order);
  }
  // function which gets the new created documents id

  

  // function to get all the orders, which have an active status

  Stream<List<Map<String, dynamic>>> listenActiveOrders() {
  return FirebaseFirestore.instance
      .collection("orders")
      .where("status", isEqualTo: "active") 
      .snapshots()
      .map((snapshot) {
        return snapshot.docs.map((doc) {
          return {
            "id": doc.id,
            ...doc.data(),
          };
        }).toList();
      });
}
  // function to change the status of an order to inactive, since its done
}
