import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../logic/controllers/auth_controller.dart';
import '../../../logic/controllers/product_controller.dart';
import 'add_product_screen.dart';
import 'edit_product_screen.dart';

class AdminProductScreen extends StatelessWidget {
  final ProductController productController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            var product = productController.products[index];
            return ListTile(
              leading: product.imageUrl!.isNotEmpty
                  ? Image.network(product.imageUrl ?? '')
                  : null,
              title: Text(product.name ?? ''),
              subtitle: Text('\$${product.price}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed:
                        () => Get.to(() => EditProductScreen(product: product)),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed:
                        () => productController.deleteProduct(product.id),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => AddProductScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
