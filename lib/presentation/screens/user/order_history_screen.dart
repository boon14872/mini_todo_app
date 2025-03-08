import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../logic/controllers/order_controller.dart';
import '../../../logic/controllers/auth_controller.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderController orderController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    orderController.fetchOrders(authController.user.value!.uid);
    return Scaffold(
      appBar: AppBar(title: Text('Order History')),
      body: Obx(() => ListView.builder(
            itemCount: orderController.orders.length,
            itemBuilder: (context, index) {
              var order = orderController.orders[index];
              return ListTile(
                title: Text('Order #${order.orderId}'),
                subtitle: Text('Total: \$${order.totalPrice} - ${order.date.toString()}'),
              );
            },
          )),
    );
  }
}