import 'package:devroninsemployees/constants/strings.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  static LoginPageController instance = Get.find();
  RxBool isEnableSignUp = false.obs;
  RxBool isVisiblePassword = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool isEnableNextButton = true.obs;
  var selectedDropdown = Strings.associate.obs;
  List dropdownTextList = [
    Strings.associate,
    Strings.srAssociate,
    Strings.softwareEngineer,
    Strings.srSoftwareEngineer,
    Strings.teamLead,
    Strings.projectManager,
  ];

  void toggleSignUp() {
    isEnableSignUp.value = !isEnableSignUp.value;
    email = ''.obs;
    password = ''.obs;
    confirmPassword = ''.obs;
    update();
  }

  void toggleNextButton() {
    isEnableNextButton.value = !isEnableNextButton.value;
    update();
  }

  void dropDownValueChange(String value) {
    selectedDropdown.value = value;
  }

  void togglePassword() {
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
