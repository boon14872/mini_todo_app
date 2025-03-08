import 'package:get/get.dart';
import '../../data/models/cart_item_model.dart';
import '../../data/models/order_model.dart';
import '../../data/services/firestore_service.dart';

class OrderController extends GetxController {
  var orders = <OrderModel>[].obs;
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> createOrder(List<CartItemModel> items, double totalPrice, String userId) async {
    try {
      if (items.isEmpty) {
        Get.snackbar('Error', 'Cart is empty');
        return;
      }
      var order = OrderModel(
        orderId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        items: items,
        totalPrice: totalPrice,
        date: DateTime.now(),
      );
      await _firestoreService.addOrder(order);
      Get.snackbar('Success', 'Order placed');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void fetchOrders(String userId) async {
    var orderList = await _firestoreService.getOrders(userId);
    orders.assignAll(orderList);
  }
}