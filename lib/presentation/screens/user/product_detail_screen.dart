import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../logic/controllers/cart_controller.dart';
import '../../../core/widgets/custom_button.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  final CartController cartController = Get.find();

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name ?? '')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.imageUrl!.isNotEmpty
                ? Image.network(
                  product.imageUrl ?? '',
                  height: 200,
                  fit: BoxFit.cover,
                )
                : SizedBox.shrink(),
            SizedBox(height: 20),
            Text(
              product.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text('\$${product.price}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(product.description ?? ''),
            Spacer(),
            CustomButton(
              text: 'Add to Cart',
              onPressed: () => cartController.addToCart(product),
            ),
          ],
        ),
      ),
    );
  }
}
