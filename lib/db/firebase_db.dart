import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/encription/encypt_data.dart';
import 'package:devroninsemployees/model/user_model.dart';
import 'package:devroninsemployees/utils/calender_data_source.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/src/storage_impl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class FirebaseDb {
  static registerUser(UserModel userModel, GetStorage box, BuildContext context) async {
    await AuthController().fireStore.collection(Strings.users).doc(userModel.uid).set({
      'uid': userModel.uid,
      'firstName': userModel.firstName,
      'lastName': userModel.lastName,
      'email': userModel.email,
      'password': userModel.password,
      'designation': userModel.designation,
      'role': userModel.role,
      'phone': userModel.phone
    });
    Get.back();
    FlashMessage.showFlashMessage(
        title: Strings.registeredSuccess, message: Strings.withEmail + userModel.email, contentType: ContentType.success, context: context);
  }

  static Stream<List<UserModel>> usersStream() {
    return AuthController().fireStore.collection(Strings.users).where('role', isNotEqualTo: Strings.roleAdmin).snapshots().map((querySnapshot) {
      List<UserModel> users = [];
      for (var user in querySnapshot.docs) {
        final userModel = UserModel.fromDocumentSnapshot(snapshot: user);
        users.add(userModel);
      }
      return users;
    });
  }

  static Future<String?> uploadAndGetImgUrlInStorage(XFile file) async {
    if (file == null) {
      return null;
    }
    String imageName = ("image_${DateTime.now().microsecondsSinceEpoch}.jpg");
    Reference ref = FirebaseStorage.instance.ref().child('users').child('/$imageName');
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );

    if (kIsWeb) {
      await ref.putData(await file.readAsBytes(), metadata);
      return await ref.getDownloadURL();
    } else {
      await ref.putFile(File(file.path), metadata);
      return await ref.getDownloadURL();
    }
  }

  static storeCalenderData(FirebaseFirestore firestore, Meeting meeting, BuildContext context) async {
    await firestore
        .collection(Strings.calender.toLowerCase())
        .doc()
        .set({'eventName': meeting.eventName, 'isAllDay': meeting.isAllDay, 'date': meeting.date.toString()});
    Get.back();
    FlashMessage.showFlashMessage(title: Strings.eventAdded, message: meeting.eventName, contentType: ContentType.success, context: context);
  }

  static Stream<List<Meeting>> calenderStream(FirebaseFirestore firestore) {
    return firestore.collection(Strings.calender.toLowerCase()).snapshots().map((querySnapshot) {
      List<Meeting> calender = [];
      for (var holidays in querySnapshot.docs) {
        final calenderModel = Meeting.fromDocumentSnapshot(snapshot: holidays);
        calender.add(calenderModel);
      }
      return calender;
    });
  }

  static loginWithEmailAndPassword(FirebaseFirestore fireStore, String email, String password, BuildContext context, GetStorage box) async {
    await fireStore.collection(Strings.users).where(Strings.email.toLowerCase(), isEqualTo: email).get().then((querySnapShot) async {
      print("snapshot$querySnapShot");
      if (querySnapShot.docs.isNotEmpty) {
        for (var snapshot in querySnapShot.docs) {
          String getPassword = snapshot.get(Strings.password.toLowerCase());
          String userId = snapshot.get(Strings.uid);

          await EncryptData.decyptAES(getPassword);
          if (password == EncryptData.decrypted) {
            FlashMessage.showFlashMessage(
                title: Strings.loginSuccess, message: Strings.withEmail + email, contentType: ContentType.success, context: context);
            box.write(Strings.uidKey, userId);
          } else {
            FlashMessage.showFlashMessage(
                title: Strings.passwordDonotMatch, message: Strings.withEmail + email, contentType: ContentType.failure, context: context);
          }
        }
      } else {
        FlashMessage.showFlashMessage(
            title: Strings.accountNotFound, message: Strings.withEmail + email, contentType: ContentType.failure, context: context);
      }
    }).onError((error, stackTrace) {
      print("Error $error");
      FlashMessage.showFlashMessage(title: Strings.error, message: error.toString(), contentType: ContentType.failure, context: context);
    });
  }

  static Stream<String> roleStream(
    FirebaseFirestore fireStore,
    String userId,
  ) {
    return fireStore.collection(Strings.users).doc(userId).snapshots().map((docSnapshot) {
      String role = docSnapshot.get('role');
      return role;
    });
  }

  static deleteUser() {}
}
