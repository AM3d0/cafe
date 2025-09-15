class CartItem {
  final String name;
  final String quantity;
  final String priceSum;
  final List<String> extras;
  final String? note;
  CartItem({
    required this.name,
    required this.quantity,
    required this.priceSum,
    this.extras = const [],
    this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      "productName": name,
      "quantity": quantity,
      "price": priceSum,
      "extras": extras,
      "note": note,
    };
  }
}
