import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/model/technology_model.dart';

class UserModel {
  late String uid;
  late String firstName;
  late String lastName;
  late String email;
  late String password;
  late String designation;
  late String role;
  late String phone;
  late String profileUrl;
  late List<TechnologyModel> technology;
  String? techName;

  UserModel(
      {required this.uid,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.designation,
      required this.role,
      required this.phone,
      required this.profileUrl,
      required this.technology,
      this.techName});
  UserModel.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    uid = snapshot.id;
    firstName = snapshot.get('firstName');
    lastName = snapshot.get('lastName');
    email = snapshot.get('email');
    password = snapshot.get('password');
    designation = snapshot.get('designation');
    role = snapshot.get('role');
    phone = snapshot.get('phone');
    profileUrl = snapshot.get('profileUrl');
    technology = snapshot.get('technology');
  }
}
