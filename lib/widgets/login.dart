import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/utils/wave_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  Login({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        loginToYourAccount(context),
        textFieldEmail,
        const SizedBox(
          height: 16,
        ),
        textFieldPassword,
        const SizedBox(
          height: 20,
        ),
        forgotPasswordBtn,
        const SizedBox(
          height: 20,
        ),
        loginButton(context),
        waveLoading
      ],
    );
  }

  Text loginToYourAccount(BuildContext context) {
    return Text(
      Strings.loginToYourAccount,
      style: TextStyle(fontSize: ResponsiveLayout.isLargeScreen(context) || ResponsiveLayout.isMediumScreen(context) ? 20 : 16),
    );
  }

  Align get forgotPasswordBtn =>
      Align(alignment: Alignment.bottomRight, child: TextButton(onPressed: () {}, child: const Text(Strings.forgotPassword)));

  Obx get waveLoading {
    return Obx(
      () => AuthController.instance.isLoading.value
          ? const WaveLoading()
          : const SizedBox(
              height: 12,
            ),
    );
  }

  InkWell loginButton(context) {
    return InkWell(
        onTap: () {
          if (!LoginPageController.instance.email.contains(Strings.emailValidation) && LoginPageController.instance.email.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error, message: Strings.invalidDevroninsEmail, contentType: ContentType.help, context: context);
          } else if (LoginPageController.instance.password.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error, message: Strings.pleaseCheckYourPassword, contentType: ContentType.failure, context: context);
          } else {
            LoginPageController.instance
                .loginUser(LoginPageController.instance.email.value.trim(), LoginPageController.instance.password.value.trim(), context);

            LoginPageController.instance.email.value = '';
            LoginPageController.instance.password.value = '';
          }
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
              boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
          child: const Center(
            child: Text(Strings.login,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1,
                )),
          ),
        ));
  }

  Container get textFieldPassword {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Obx(() => TextField(
            obscureText: LoginPageController.instance.isVisiblePassword.value,
            onChanged: (value) {
              LoginPageController.instance.passwordChange(value.obs);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: Strings.password,
                suffixIcon: IconButton(
                  icon: Icon(LoginPageController.instance.isVisiblePassword.value ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    LoginPageController.instance.togglePassword();
                  },
                )),
          )),
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
      child: TextField(
        onChanged: (value) {
          LoginPageController.instance.emailChange(value.obs);
        },
        decoration: const InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.email),
      ),
    );
  }
}
