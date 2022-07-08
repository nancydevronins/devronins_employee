import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class FlashMessage {
  static showFlashMessage({required String title, required String message, required ContentType contentType, required BuildContext context}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AwesomeSnackbarContent(
            title: title,
            message: message,
            contentType: contentType,
          ),
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
      ));
}
