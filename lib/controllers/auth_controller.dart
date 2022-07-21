import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/user_model.dart';
import 'package:devroninsemployees/routes/routes.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  RxString role = ''.obs;
  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAllNamed(RoutesClass.loginPage);
    } else if (role.value.isEmpty) {
      getUserRole(user.uid);
    }
  }

  void registerUser(String email, String password, String firstName, String lastName, String phone, String designation, BuildContext context) async {
    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        FlashMessage.showFlashMessage(
            title: Strings.registeredSuccess, message: Strings.withEmail + email, contentType: ContentType.success, context: context);
        FirebaseDb.addUser(UserModel(
            uid: value.user!.uid,
            firstName: firstName,
            lastName: lastName,
            email: email,
            designation: designation,
            role: Strings.roleEmployee,
            phone: phone));
      });
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      FlashMessage.showFlashMessage(
          title: e.toString().substring(15, 28), message: e.message.toString(), contentType: ContentType.failure, context: context);
    }
    update();
  }

  void loginUser(String email, String password, BuildContext context) async {
    try {
      isLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) async {
        await getUserRole(value.user!.uid);
        FlashMessage.showFlashMessage(
            title: Strings.loginSuccess, message: Strings.withEmail + email, contentType: ContentType.success, context: context);
      });
      isLoading(false);
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      FlashMessage.showFlashMessage(
          title: e.toString().substring(15, 28), message: e.message.toString(), contentType: ContentType.failure, context: context);
    }
    update();
  }

  getUserRole(uid) async {
    await fireStore.collection(Strings.users).doc(uid).get().then((value) {
      role.value = value.get(Strings.role);
    });
    navigation();
    print("Role:$role");
  }

  void navigation() {
    if (role.value == Strings.roleAdmin) {
      Get.offAllNamed(RoutesClass.adminHome);
    } else {
      Get.offAllNamed(RoutesClass.home);
    }
  }

  void logout() async {
    auth.signOut();
  }
}
