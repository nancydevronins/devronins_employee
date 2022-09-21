import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../db/firebase_db.dart';
import '../encription/encypt_data.dart';
import '../model/technology_model.dart';
import '../model/user_model.dart';
import 'package:uuid/uuid.dart';

import '../utils/flash_message.dart';

class LoginPageController extends GetxController {
  static LoginPageController instance = Get.find();
  var uuid = const Uuid();
  final box = GetStorage();
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
  TechnologyModel? technologyitem;
  List<TechnologyModel> selectedTechnology = [];

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

  List dropDownTechnologyList = [
    Strings.selectTechnology,
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

  void loginUser(String email, String password, BuildContext context) async {
    isLoading(true);
    await FirebaseDb.loginWithEmailAndPassword(email, password, context, box);
    isLoading(false);
  }

  void registerUser(
      String email,
      String password,
      String firstName,
      String lastName,
      String phone,
      String profileUrl,
      String designation,
      selectedTechnology,
      context) async {
    try {
      isLoading(true);
      print(selectedTechnology);
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
              profileUrl: profileUrl,
              technology: selectedTechnology),
          box,
          context);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      FlashMessage.showFlashMessage(
          title: 'Error',
          message: e.toString(),
          contentType: ContentType.failure,
          context: context);
    }
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
