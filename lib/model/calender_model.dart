import 'package:cloud_firestore/cloud_firestore.dart';

class CalenderModel {
  late String festival;
  late String date;
  CalenderModel({required this.festival, required this.date});
  CalenderModel.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    festival = snapshot.get('festival');
    date = snapshot.get('date');
  }
}
