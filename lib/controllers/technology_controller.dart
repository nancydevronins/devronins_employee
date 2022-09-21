import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/technology_model.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class TechnologyController extends GetxController {
  static TechnologyController instance = Get.find();
  Rx<List<TechnologyModel>> technologyList = Rx<List<TechnologyModel>>([]);
  List<TechnologyModel> get technology => technologyList.value;

  List<TechnologyModel> selectedServices = [];
  @override
  void onReady() {
    technologyList.bindStream(FirebaseDb.technologyStream());

    super.onReady();
  }

  void removeSelectedValue(value) {
    selectedServices.remove(value);
  }
}
