import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devronins_employeeee/modals/services_modal.dart';
import 'package:devronins_employeeee/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  static AuthController instance = Get.find();
  late Rx<User?> user;
  FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  static UserCredential? userCredential;
  RxList<Designations> designationsListing = RxList<Designations>([]);

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(auth.currentUser);
    user.bindStream(auth.userChanges());
    ever(user, _initialScreen);
  }

  @override
  onInit() {
    designationsListing.bindStream(designations());
    super.onInit();
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(const LoginScreen());
    }
  }

  Future<UserCredential> registerUser(String email, String password, String? firstName, String? lastName) async {
    return await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<dynamic> loginUser(String email, String password) async {
    try {
      return await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  void addEmployee(String firstName, String lastName, String email, String uId, Designations designations) async {
    DocumentReference documentReference = firebaseFirestore.collection("employees").doc(userCredential?.user?.uid);
    Map<String, dynamic> data = <String, dynamic>{
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "designation": designations.designationTitle,
      "id": uId,
    };

    await documentReference.set(data).whenComplete(() {
      Get.toNamed("/employee");
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
    });
  }

  void updateEmployeeData(String firstName, String lastName, String email, String uId) {
    firebaseFirestore.collection("employees").doc(uId).update({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    }).whenComplete(() {
      print('Note item deleted from the database');
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
      print(e);
    });
  }

  void deleteEmployeeData(String uId) {
    firebaseFirestore.collection("employees").doc(uId).delete().whenComplete(() {
      Get.toNamed("/employee");
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
    });
  }

  void addDesignation(String designationName) async {
    DocumentReference documentReference = firebaseFirestore.collection("designations").doc();
    Map<String, dynamic> data = <String, dynamic>{
      "label": designationName,
      "docId": documentReference.id,
    };

    await documentReference.set(data).whenComplete(() {
      Get.toNamed("/designations");
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
    });
  }

  void updateDesignations(String designation, String docId) async {
    firebaseFirestore.collection("designations").doc(docId).update({
      "label": designation,
    }).whenComplete(() {
      Get.toNamed("/designations");
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
      print(e);
    });
  }

  void deleteDesignation(designation) async {
    firebaseFirestore.collection("designations").doc(designation).delete().whenComplete(() {
      Get.toNamed("/designations");
    }).catchError((e) {
      Get.snackbar("About User", "User Message", backgroundColor: Colors.transparent, snackPosition: SnackPosition.BOTTOM, titleText: const Text("Account creation failed"), messageText: Text(e.toString()));
      print(e);
    });
    update();
  }

  Stream<List<Designations>> designations({bool? fromRefresh}) {
    return firebaseFirestore.collection("designations").snapshots().map((QuerySnapshot query) => query.docs.map((item) => Designations.fromMap(item)).toList());
  }

  Future<void> logOut() async {
    auth.signOut();
  }
}
