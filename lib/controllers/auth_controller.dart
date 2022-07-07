import 'package:devroninsemployees/routes/routes.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAllNamed(RoutesClass.loginPage);
    } else {
      Get.offAllNamed(RoutesClass.home);
    }
  }

  void registerUser(String email, String password, BuildContext context) async {
    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      print("Error:$e");
    }
    update();
  }

  void loginUser(String email, String password, BuildContext context) async {
    try {
      isLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      FlashMessage.showFlashMessage("message", "messageDetail", context);
      print("Error:$e");
    }
    update();
  }
}
