import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  Rx<List<UserModel>> usersList = Rx<List<UserModel>>([]);
  List<UserModel> get users => usersList.value;

  @override
  void onReady() {
    usersList.bindStream(FirebaseDb.usersStream());
    super.onReady();
  }
}
