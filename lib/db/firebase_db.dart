import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/model/user_model.dart';

class FirebaseDb {
  static addUser(UserModel userModel) async {
    await AuthController().fireStore.collection(Strings.users).doc(AuthController().auth.currentUser!.uid).set({
      'uid': userModel.uid,
      'firstName': userModel.firstName,
      'lastName': userModel.lastName,
      'email': userModel.email,
      'designation': userModel.designation,
      'role': userModel.role,
      'phone': userModel.phone
    });
  }

  static Stream<List<UserModel>> usersStream() {
    return AuthController().fireStore.collection(Strings.users).snapshots().map((querySnapshot) {
      List<UserModel> users = [];
      for (var user in querySnapshot.docs) {
        final userModel = UserModel.fromDocumentSnapshot(snapshot: user);
        users.add(userModel);
      }
      return users;
    });
  }

  static deleteUser() {}
}
