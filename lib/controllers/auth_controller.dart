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
import 'package:uuid/uuid.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxString role = ''.obs;
  var uuid = const Uuid();
  final box = GetStorage();
  RxString userId = ''.obs;

  @override
  void onReady() {
    super.onReady();
    box.listen(() {
      String? userId = box.read(Strings.uidKey);
      if (userId != null) {
        role.bindStream(FirebaseDb.roleStream(fireStore, userId));
      }
      ever(role, _initialScreen);
    });
  }

  _initialScreen(role) async {
    print("Role:$role");
    if (role == null) {
      Get.offAllNamed(RoutesClass.loginPage);
    } else {
      navigation();
    }
  }

  void registerUser(String email, String password, String firstName, String lastName, String phone, String designation, context) async {
    try {
      isLoading(true);
      await EncryptData.encyptAES(password);

      await FirebaseDb.registerUser(
          UserModel(
            uid: uuid.v4(),
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: EncryptData.encrypted!.base16,
            designation: designation,
            role: Strings.roleEmployee,
            phone: phone,
          ),
          box,
          context);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      FlashMessage.showFlashMessage(title: 'Error', message: e.toString(), contentType: ContentType.failure, context: context);
    }
    update();
  }

  void loginUser(String email, String password, BuildContext context) async {
    isLoading(true);
    await FirebaseDb.loginWithEmailAndPassword(fireStore, email, password, context, box);
    isLoading(false);

    update();
  }

  void navigation() {
    if (role.value == Strings.roleAdmin) {
      Get.offAllNamed(RoutesClass.adminHome);
    } else if (role.value == Strings.roleEmployee) {
      Get.offAllNamed(RoutesClass.home);
    } else {
      Get.offAllNamed(RoutesClass.loginPage);
    }
  }

  void logout() async {
    await box.erase();
    navigation();
  }
}
