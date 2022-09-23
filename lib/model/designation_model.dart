import 'package:cloud_firestore/cloud_firestore.dart';

class DesignationModel {
  String? id;
  String? designationName;

  DesignationModel({this.id, this.designationName});

  DesignationModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    designationName = snapshot['designationName'];
    print(designationName);
  }
}
