import 'package:flutter/material.dart';

class Validator {
  static String validateEmail(String value, BuildContext context) {
    const pattern1 = r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    final regExp1 = RegExp(pattern1);
    if (value.isEmpty) {
      return " please enter the email address";
    } else if (!regExp1.hasMatch(value)) {
      return "Please enter the valid email ,address";
    }
    return "0";
  }

  static String validatePassword(String value, BuildContext context) {
    if (value.isEmpty) {
      return " Please enter the password";
    } else if (value.length > 6) {
      return "password length shoud be greater then six";
    }
    return "0";
  }
}
