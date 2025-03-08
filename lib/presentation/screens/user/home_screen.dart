import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_todo_app/logic/controllers/navigation_controller.dart';
import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/product_controller.dart';
import '../../widgets/product_card.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';

class HomeScreen extends StatelessWidget {
  final ProductController productController = Get.find();
  final AuthController authController = Get.find();
  final NavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(() {
        if (navigationController.currentIndex.value == 0) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: productController.products.length,
            itemBuilder: (context, index) {
              return ProductCard(product: productController.products[index]);
            },
          );
        } else if (navigationController.currentIndex.value == 1) {
          return CartScreen();
        } else if (navigationController.currentIndex.value == 2) {
          return OrderHistoryScreen();
        } else {
          return Center(child: Text('Page not found'));
        }
      }),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: navigationController.currentIndex.value,
          onTap: (index) => navigationController.currentIndex.value = index,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Orders'),
          ],
        ),
      ),
    );
  }
}
