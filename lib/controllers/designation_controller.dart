import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/designation_model.dart';
import 'package:get/get.dart';

class DesignationController extends GetxController {
  static DesignationController instance = Get.find();

  Rx<List<DesignationModel>> designationList = Rx<List<DesignationModel>>([]);
  List<DesignationModel> get designations => designationList.value;

  @override
  void onReady() {
    designationList.bindStream(FirebaseDb.designationStream());
    super.onReady();
  }
}
