import 'package:cloud_firestore/cloud_firestore.dart';

class Designations {
  late String designationTitle;
  late String docId;

  Designations.fromMap(DocumentSnapshot data) {
    designationTitle = data["label"];
    docId = data["docId"];
  }
}
