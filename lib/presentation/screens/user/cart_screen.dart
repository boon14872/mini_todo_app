import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/custom_button.dart';
import '../../../logic/controllers/cart_controller.dart';
import '../../../logic/controllers/order_controller.dart';
import '../../../logic/controllers/auth_controller.dart';

class CartScreen extends StatelessWidget {
  final CartController cartController = Get.find();
  final OrderController orderController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: Obx(() => ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              var item = cartController.cartItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('\$${item.price} x ${item.quantity}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => cartController.updateQuantity(item.productId, item.quantity - 1),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => cartController.updateQuantity(item.productId, item.quantity + 1),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => cartController.removeFromCart(item.productId),
                    ),
                  ],
                ),
              );
            },
          )),
      bottomSheet: Obx(() => Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: \$${cartController.totalPrice}', style: TextStyle(fontSize: 20)),
                CustomButton(
                  text: 'Checkout',
                  onPressed: () {
                    orderController.createOrder(
                      cartController.cartItems,
                      cartController.totalPrice,
                      authController.user.value!.uid,
                    );
                    cartController.cartItems.clear();
                  },
                ),
              ],
            ),
          )),
    );
  }
}