import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUp extends StatelessWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.signUpToYOurAccount,
          style: TextStyle(fontSize: ResponsiveLayout.isLargeScreen(context) && ResponsiveLayout.isMediumScreen(context) ? 20 : 16),
        ),
        textFieldEmail,
        const SizedBox(
          height: 16,
        ),
        textFieldPassword,
        const SizedBox(
          height: 16,
        ),
        textFieldConfirmPassword,
        const SizedBox(
          height: 20,
        ),
        signupBtn(context),
        const SizedBox(
          height: 12,
        ),
      ],
    );
  }

  InkWell signupBtn(context) {
    return InkWell(
        onTap: () {
          AuthController.instance.registerUser(LoginPageController.instance.email.value, LoginPageController.instance.password.value, context);
        },
        child: Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                AppColors.greenColor,
                AppColors.blueColor,
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: const Offset(0, 8), blurRadius: 8)]),
          child: const Center(
            child: Text(Strings.signUp,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1,
                )),
          ),
        ));
  }

  Container get textFieldConfirmPassword {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: const TextField(
        decoration: InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.confirmPassword),
      ),
    );
  }

  Container get textFieldPassword {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextField(
        obscureText: LoginPageController.instance.isVisiblePassword.value,
        onChanged: (value) {},
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            hintText: Strings.password,
            suffixIcon: IconButton(
              icon: Icon(LoginPageController.instance.isVisiblePassword.value ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                LoginPageController.instance.enablePassword();
              },
            )),
      ),
    );
  }

  Container get textFieldEmail {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: const TextField(
        decoration: InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.email),
      ),
    );
  }
}
