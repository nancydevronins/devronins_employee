import 'package:another_flushbar/flushbar.dart';
import 'package:devronins_employeeee/constants/colors.dart';
import 'package:devronins_employeeee/constants/strings.dart';
import 'package:flutter/material.dart';

class FirebaseConstants {
  static String table_designations = "designations";
}

Future<dynamic> openPage(BuildContext context, Widget page) async {
  final result = await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
  return result;
}

String getString(BuildContext context, String key) {
  return AppStrings().translate(key);
}

showSnackBar(BuildContext context, String message) {
  var snackBar = SnackBar(
    content: Text(
      message,
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: 'SemiBold',
      ),
    ),
    backgroundColor: AppColor.appBlue,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<void> showTopSnackBar(BuildContext context,
    {String? title,
      required String message,
      Color color = AppColor.appBlue,
      int durationInSecond = 2}) async {
  await Flushbar(
    title: title,
    message: message,
    duration: Duration(seconds: durationInSecond),
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: color,
    animationDuration: const Duration(milliseconds: 200),
  ).show(context);
}

bool isValidEmail(String? email) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(email ?? '');
}

bool isValidPasswordLength(String? password) {
  return (password?.length ?? 0) >= 6;
}

bool isValidPhone(String? number) {
  return (number != null &&
      number.isNotEmpty &&
      number.length >= 9 &&
      number.length <= 13);
}

AlertDialog? dialog;

void progressDialog(bool isLoading, BuildContext context) {
  try {
    if (dialog != null && !isLoading) {
      Navigator.of(context, rootNavigator: true).pop();
      dialog = null;
    } else if (isLoading && dialog == null) {
      dialog = AlertDialog(
        content: SizedBox(
            height: 40,
            child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[const CircularProgressIndicator(), const Padding(padding: EdgeInsets.only(left: 15)), Text(getString(context, "please_wait"))],
              ),
            )),
        contentPadding: const EdgeInsets.all(15),
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => dialog!,
        useRootNavigator: true,
      );
    }
  } catch (exception) {
    dialog == null;
    print(exception.toString());
  }
}


