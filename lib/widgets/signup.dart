import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/utils/wave_loading.dart';
import 'package:devroninsemployees/widgets/profile_setup.dart';
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
        Obx(
          () => LoginPageController.instance.isEnableNextButton.value
              ? Column(
                  children: [
                    signupToYourAccount(context),
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
                  ],
                )
              : ProfileSetup(),
        ),
        twoDotIndicator,
        const SizedBox(
          height: 20,
        ),
        nextBtn(context),
        waveLoading,
      ],
    );
  }

  Obx get twoDotIndicator {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: LoginPageController.instance.isEnableNextButton.value
                    ? AppColors.blueColor
                    : Colors.grey,
                shape: BoxShape.circle),
          ),
          const SizedBox(
            width: 8,
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: LoginPageController.instance.isEnableNextButton.value
                    ? Colors.grey
                    : AppColors.blueColor,
                shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  Text signupToYourAccount(BuildContext context) {
    return Text(
      Strings.signUpToYOurAccount,
      style: TextStyle(
          fontSize: ResponsiveLayout.isLargeScreen(context) &&
                  ResponsiveLayout.isMediumScreen(context)
              ? 20
              : 16),
    );
  }

  Obx get waveLoading {
    return Obx(
      () => AuthController.instance.isLoading.value
          ? const WaveLoading()
          : const SizedBox(
              height: 12,
            ),
    );
  }

  Obx nextBtn(context) {
    return Obx(() => InkWell(
        onTap: () {
          if (!LoginPageController.instance.email
              .contains(Strings.emailValidation)) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.invalidDevroninsEmail,
                contentType: ContentType.help,
                context: context);
          } else if (LoginPageController.instance.password.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.passwordRequired,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.confirmPassword.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.enterConfirmPassword,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.password.value.trim() !=
              LoginPageController.instance.confirmPassword.trim()) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.passwordDonotMatch,
                contentType: ContentType.failure,
                context: context);
          } else if (!LoginPageController.instance.isEnableNextButton.value) {
            if (LoginPageController.instance.firstName.isEmpty) {
              FlashMessage.showFlashMessage(
                  title: Strings.error,
                  message: Strings.firstNameRequired,
                  contentType: ContentType.failure,
                  context: context);
            } else if (LoginPageController.instance.lastName.isEmpty) {
              FlashMessage.showFlashMessage(
                  title: Strings.error,
                  message: Strings.lastNameRequired,
                  contentType: ContentType.failure,
                  context: context);
            } else if (LoginPageController.instance.phoneNumber.isEmpty) {
              FlashMessage.showFlashMessage(
                  title: Strings.error,
                  message: Strings.phoneNumberRequired,
                  contentType: ContentType.failure,
                  context: context);
            } else {
              LoginPageController.instance.registerUser(
                  LoginPageController.instance.email.value.trim(),
                  LoginPageController.instance.password.value.trim(),
                  LoginPageController.instance.firstName.value,
                  LoginPageController.instance.lastName.value,
                  LoginPageController.instance.phoneNumber.value,
                  LoginPageController.instance.profileUrl.value,
                  LoginPageController.instance.selectedDropdown.value,
                  LoginPageController.instance.selectedTechnology,
                  context);
            }
          } else {
            LoginPageController.instance.toggleNextButton();
          }

          // if (LoginPageController.instance.password.value.trim() != LoginPageController.instance.confirmPassword.trim()) {
          //   FlashMessage.showFlashMessage(
          //       message: Strings.pleaseCheckYourPassword, title: Strings.passwordDontMatch, context: context, contentType: ContentType.failure);
          // } else if (!LoginPageController.instance.email.contains(Strings.emailValidation)) {
          //   FlashMessage.showFlashMessage(
          //       title: Strings.error, message: Strings.invalidDevroninsEmail, contentType: ContentType.help, context: context);
          // } else {
          //   AuthController.instance
          //       .registerUser(LoginPageController.instance.email.value.trim(), LoginPageController.instance.password.value.trim(), context);
          // }
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
              boxShadow: [
                BoxShadow(
                    color: AppColors.blueColor.withOpacity(.3),
                    offset: const Offset(0, 8),
                    blurRadius: 8)
              ]),
          child: Center(
            child: Text(
                LoginPageController.instance.isEnableNextButton.value
                    ? Strings.next
                    : Strings.signUp,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 1,
                )),
          ),
        )));
  }

  Container get textFieldConfirmPassword {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextField(
        obscureText: true,
        onChanged: (value) {
          LoginPageController.instance.confirmPasswordChange(value.obs);
        },
        decoration: const InputDecoration(
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            hintText: Strings.confirmPassword),
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
        child: Obx(
          () => TextField(
            obscureText: LoginPageController.instance.isVisiblePassword.value,
            onChanged: (value) {
              LoginPageController.instance.passwordChange(value.obs);
            },
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: Strings.password,
                suffixIcon: IconButton(
                  icon: Icon(
                      LoginPageController.instance.isVisiblePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility),
                  onPressed: () {
                    LoginPageController.instance.togglePassword();
                  },
                )),
          ),
        ));
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
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(12),
            border: InputBorder.none,
            hintText: Strings.email),
      ),
    );
  }
}
