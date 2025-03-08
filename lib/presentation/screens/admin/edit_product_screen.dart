import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/product_model.dart';
import '../../../logic/controllers/product_controller.dart';
import '../../../core/widgets/custom_button.dart';

class EditProductScreen extends StatelessWidget {
  final ProductModel product;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final ProductController productController = Get.find();

  EditProductScreen({required this.product}) {
    nameController.text = product.name ?? '';
    priceController.text = product.price.toString();
    descriptionController.text = product.description ?? '';
    imageUrlController.text = product.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              product.imageUrl!.isNotEmpty
                  ? Image.network(
                    product.imageUrl ?? '',
                    height: 150,
                    fit: BoxFit.cover,
                  )
                  : SizedBox.shrink(),
              SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: 'Save',
                onPressed: () {
                  productController.updateProduct(
                    ProductModel(
                      id: product.id,
                      name: nameController.text,
                      price: double.parse(priceController.text),
                      imageUrl: imageUrlController.text,
                      description: descriptionController.text,
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Delete',
                onPressed: () => productController.deleteProduct(product.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
