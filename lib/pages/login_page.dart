import 'package:devroninsemployees/constants/images.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/login.dart';
import 'package:devroninsemployees/widgets/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: ResponsiveLayout.isLargeScreen(context) ? 500 : null,
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [BoxShadow(color: Colors.black12, offset: Offset(0, 8), blurRadius: 8)]),
                child: Obx(() {
                  return Column(
                    children: [
                      LoginPageController.instance.isEnableSignUp.value ? SignUp() : Login(),
                      TextButton(
                          onPressed: () {
                            LoginPageController.instance.enableSignUp();
                          },
                          child: Text(LoginPageController.instance.isEnableSignUp.value ? Strings.alreadyHaveAnAccount : Strings.newUserSignupHere))
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }
}
