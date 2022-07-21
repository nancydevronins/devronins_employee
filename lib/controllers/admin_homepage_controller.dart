import 'package:get/get.dart';

class AdminHomePageController extends GetxController {
  static AdminHomePageController instance = Get.find();
  RxString appBarTitle = 'Welcome'.obs;
  var screenIndex = 0.obs;
  RxBool isHover1 = false.obs;
  RxBool isHover2 = false.obs;
  RxBool isHover3 = false.obs;
  RxBool isVisiblePassword = true.obs;
}
