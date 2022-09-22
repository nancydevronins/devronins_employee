import 'package:cloud_firestore/cloud_firestore.dart';

class TechnologyModel {
  String? id;
  String? technologyName;

  TechnologyModel({this.id, this.technologyName});

  TechnologyModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['technologyId'];
    technologyName = snapshot['technologyName'];
  }
}
