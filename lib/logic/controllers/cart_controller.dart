import 'package:get/get.dart';
import '../../data/models/product_model.dart';
import '../../data/models/cart_item_model.dart';

class CartController extends GetxController {
  // Observable list of cart items
  var cartItems = <CartItemModel>[].obs;

  // Add product to cart
  void addToCart(ProductModel product) {
    var existingItem = cartItems.firstWhereOrNull(
      (item) => item.productId == product.id,
    );
    if (existingItem != null) {
      existingItem.quantity++; // Increment quantity
      cartItems.refresh(); // Notify UI of change
    } else {
      cartItems.add(
        CartItemModel(
          productId: product.id,
          name: product.name ?? 'Unnamed Product',
          price: product.price,
          quantity: 1,
        ),
      );
    }
    Get.snackbar('Added', '${product.name ?? 'Item'} added to cart');
  }

  // Remove product from cart
  void removeFromCart(String productId) {
    cartItems.removeWhere((item) => item.productId == productId);
  }

  // Update quantity of an item
  void updateQuantity(String productId, int quantity) {
    var itemIndex = cartItems.indexWhere((item) => item.productId == productId);
    if (itemIndex != -1) {
      if (quantity > 0) {
        cartItems[itemIndex].quantity = quantity; // Update quantity
        cartItems.refresh(); // Notify UI of change
      } else {
        removeFromCart(productId); // Remove if quantity is 0 or less
      }
    }
  }

  // Calculate total price
  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
}
