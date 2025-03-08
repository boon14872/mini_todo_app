import 'package:get/get.dart';
import '../../data/models/user_model.dart';
import '../../data/services/auth_service.dart';
import '../../presentation/screens/login_screen.dart';
import '../../presentation/screens/user/home_screen.dart';
import '../../presentation/screens/admin/admin_product_screen.dart';

class AuthController extends GetxController {
  var user = Rxn<UserModel>();
  final AuthService _authService = AuthService();

  Future<void> login(String email, String password) async {
    try {
      UserModel? loggedUser = await _authService.login(email, password);
      if (loggedUser != null) {
        user.value = loggedUser;
        if (loggedUser.role == 'admin') {
          Get.offAll(() => AdminProductScreen());
        } else {
          Get.offAll(() => HomeScreen());
        }
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    user.value = null;
    Get.offAll(() => LoginScreen());
  }
}