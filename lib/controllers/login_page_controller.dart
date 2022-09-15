import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../db/firebase_db.dart';

class LoginPageController extends GetxController {
  static LoginPageController instance = Get.find();
  RxBool isEnableSignUp = false.obs;
  RxBool isVisiblePassword = true.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;
  RxString confirmPassword = ''.obs;
  RxBool isEnableNextButton = true.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString phoneNumber = ''.obs;
  var selectedDropdown = Strings.selectDesignation.obs;
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxString profileUrl = ''.obs;
  RxBool isLoading = false.obs;
  List dropdownTextList = [
    Strings.selectDesignation,
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
  }

  void confirmPasswordChange(RxString value) {
    confirmPassword = value;
    update();
  }

  void pickAndStoreUserImageInDb() async {
    isLoading(true);
    return await _picker.pickImage(source: ImageSource.gallery).then((imgFile) {
      FirebaseDb.uploadAndGetImgUrlInStorage(imgFile!).then((url) {
        print("profileUrl${url}");
        isLoading(false);
        return profileUrl.value = url!;
      }).catchError(() {
        isLoading(false);
      });
    });
  }

  @override
  void dispose() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneController.clear();
    passwordController.clear();
    super.dispose();
  }
}
