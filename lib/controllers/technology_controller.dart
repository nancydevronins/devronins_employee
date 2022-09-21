import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/technology_model.dart';
import 'package:get/get.dart';

class TechnologyController extends GetxController {
  static TechnologyController instance = Get.find();
  Rx<List<TechnologyModel>> technologyList = Rx<List<TechnologyModel>>([]);
  List<TechnologyModel> get technology => technologyList.value;

  @override
  void onReady() {
    technologyList.bindStream(FirebaseDb.technologyStream());
    super.onReady();
  }
}
