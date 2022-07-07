import 'package:get/get.dart';

class LoginPageController extends GetxController {
  static LoginPageController instance = Get.find();
  RxBool isEnableSignUp = false.obs;
  RxBool isVisiblePassword = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;

  void enableSignUp() {
    isEnableSignUp.value = !isEnableSignUp.value;
    update();
  }

  void enablePassword() {
    isVisiblePassword.value = !isVisiblePassword.value;
    update();
  }

  void emailChange(RxString value) {
    email = value;
    update();
  }

  void passwordChange(RxString value) {
    password = value;
    update();
  }

  void confirmPasswordChange(RxString value) {
    confirmPassword = value;
    update();
  }
}
