import 'package:cafe/pages/customer_pages/cart/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersService {
  // function to push an order
  Future<void> sendOrder(List<CartItem> cart, int tableId) async {
    final order = {
      "items": cart.map((item) => item.toJson()).toList(),
      "timestamp": FieldValue.serverTimestamp(),
      "status": "active",
    };

    await FirebaseFirestore.instance
        .collection("orders")
        .doc(tableId.toString())
        .set(order);
  }
  // function to get all the orders, which have an active status

  Stream<List<Map<String, dynamic>>> listenActiveOrders() {
    return FirebaseFirestore.instance
        .collection("orders")
        .where("status", isEqualTo: "active")
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return {"id": doc.id, ...doc.data()};
          }).toList();
        });
  }

  // function to change the status of an order to inactive, since its done
  Future<void> updateStatusOfOrder(String id) async {
    await FirebaseFirestore.instance.collection('orders').doc(id).update({
      'status': 'inactive',
    });
  }

  // delete all orders from backend
  Future<void> deleteAllOrders()async
  {
    final collection = FirebaseFirestore.instance.collection('orders');
    final snapshot = await collection.get();

    for(final doc in snapshot.docs)
    {
      await doc.reference.delete();
    }
  }
  // delete certain order from backend
  void deleteOrder(String id) {
    FirebaseFirestore.instance.collection('orders').doc(id).delete();
  }
}
