import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/services/firestore_service.dart';

class ProductController extends GetxController {
  var products = <ProductModel>[].obs;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    var productList = await _firestoreService.getProducts();
    products.assignAll(productList);
  }

  Future<void> addProduct(String name, double price, String description, String imageUrl) async {
    try {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      ProductModel product = ProductModel(
        id: id,
        name: name,
        price: price,
        imageUrl: imageUrl,
        description: description,
      );
      await _firestoreService.addProduct(product);
      fetchProducts();
      Get.back();
      Get.snackbar('Success', 'Product added');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    try {
      await _firestoreService.updateProduct(product);
      fetchProducts();
      Get.back();
      Get.snackbar('Success', 'Product updated');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestoreService.deleteProduct(productId);
      fetchProducts();
      Get.snackbar('Success', 'Product deleted');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}