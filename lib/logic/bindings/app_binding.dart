import 'package:get/get.dart';
import 'package:mini_todo_app/logic/controllers/navigation_controller.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product_controller.dart';
import '../controllers/cart_controller.dart';
import '../controllers/order_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(ProductController(), permanent: true);
    Get.put(CartController(), permanent: true);
    Get.put(OrderController(), permanent: true);
    Get.put(NavigationController(), permanent: true);
  }
}
