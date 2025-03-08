import 'cart_item_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final List<CartItemModel> items;
  final double totalPrice;
  final DateTime date;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.totalPrice,
    required this.date,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => CartItemModel(
                productId: item['productId'],
                name: item['name'],
                price: item['price'].toDouble(),
                quantity: item['quantity'],
              ))
          .toList(),
      totalPrice: json['totalPrice'].toDouble(),
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
      'totalPrice': totalPrice,
      'date': date.toIso8601String(),
    };
  }
}