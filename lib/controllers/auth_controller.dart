import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/encription/encypt_data.dart';
import 'package:devroninsemployees/model/user_model.dart';
import 'package:devroninsemployees/routes/routes.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxString role = ''.obs;

  final box = GetStorage();
  RxString userId = ''.obs;
  late Worker worker;
  @override
  void onInit() {
    box.listen(() {
      String? userId = box.read(Strings.uidKey);
      if (userId != null) {
        role.bindStream(FirebaseDb.roleStream(fireStore, userId));
      }
      worker = ever(role, (roleValue) {
        print("Role:$roleValue");
        if (roleValue == null) worker.dispose;
        navigation(roleValue);
      });
    });

    super.onInit();
  }

  navigation(roleValue) {
    if (roleValue == Strings.roleAdmin) {
      Get.offAllNamed(RoutesClass.adminHome);
    } else if (roleValue == Strings.roleEmployee) {
      Get.offAllNamed(RoutesClass.home);
    } else {
      Get.offAllNamed(RoutesClass.loginPage);
    }
  }

  void loginUser(String email, String password, BuildContext context) async {
    isLoading(true);
    await FirebaseDb.loginWithEmailAndPassword(email, password, context, box);
    isLoading(false);
  }

  void logout() async {
    await box.erase();
    role.value = '';
  }
}
