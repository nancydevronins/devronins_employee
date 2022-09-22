import 'package:devroninsemployees/controllers/technology_controller.dart';
import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/technology_model.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<List<UserModel>> usersList = Rx<List<UserModel>>([]);
  List<UserModel> get users => usersList.value;
  RxDouble height = Get.height.obs;
  RxDouble width = 0.0.obs;
  RxBool isEditEnable = false.obs;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController designationController = TextEditingController();
  @override
  void onReady() {
    usersList.bindStream(FirebaseDb.usersStream());
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    designationController.clear();
    super.onClose();
  }
}
