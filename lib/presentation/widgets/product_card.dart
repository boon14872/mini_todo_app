import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../screens/user/product_detail_screen.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailScreen(product: product)),
      child: Card(
        child: Column(
          children: [
            product.imageUrl != null && product.imageUrl!.isNotEmpty
                ? Image.network(
                  product.imageUrl ?? '',
                  height: 100,
                  fit: BoxFit.cover,
                )
                : SizedBox.shrink(),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    product.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('\$${product.price}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
