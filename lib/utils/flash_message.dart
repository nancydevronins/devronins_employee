import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/images.dart';
import 'package:flutter/material.dart';

class FlashMessage {
  static showFlashMessage(String message, String messageDetail, BuildContext context) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: AwesomeSnackbarContent(
          title: 'On Snap!',
          message: 'This is an example error message that will be shown in the body of snackbar!',
          contentType: ContentType.failure,
        ),
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
      ));
}
