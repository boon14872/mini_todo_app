class CartItemModel {
  final String productId;
  final String name;
  final double price;
  int quantity;

  CartItemModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}