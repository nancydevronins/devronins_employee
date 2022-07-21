import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/controllers/user_controller.dart';
import 'package:get/get.dart';

class RootBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => LoginPageController());
    Get.lazyPut(() => AdminHomePageController());
    Get.lazyPut(() => UserController());
  }
}
