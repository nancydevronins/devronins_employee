import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/strings.dart';
import '../../controllers/admin_homepage_controller.dart';

class AddNewEmployeeForm extends StatelessWidget {
  const AddNewEmployeeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add new member',
              style: TextStyle(fontSize: ResponsiveLayout.isSmallScreen(context) ? 16 : 24),
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.clear))
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SizedBox(
          width: ResponsiveLayout.isSmallScreen(context) ? null : 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: TextEditingController(text: LoginPageController.instance.firstName.value),
                  onChanged: (value) {
                    LoginPageController.instance.firstName.value = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: Strings.firstName,
                      labelText: Strings.enterFirstName),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: TextEditingController(text: LoginPageController.instance.lastName.value),
                  onChanged: (value) {
                    LoginPageController.instance.lastName.value = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: Strings.lastName,
                      labelText: Strings.enterLastName),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: TextEditingController(text: LoginPageController.instance.email.value),
                  onChanged: (value) {
                    LoginPageController.instance.email.value = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: Strings.email,
                      labelText: Strings.enterEmail),
                ),
                SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: TextEditingController(text: LoginPageController.instance.phoneNumber.value),
                  onChanged: (value) {
                    LoginPageController.instance.phoneNumber.value = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: Strings.phoneNumber,
                      labelText: Strings.enterPhone),
                ),
                SizedBox(
                  height: 8,
                ),
                ProfileSetup().dropdownDesignations,
                SizedBox(
                  height: 8,
                ),
                Obx(
                  () => TextField(
                    controller: TextEditingController(text: LoginPageController.instance.password.value),
                    obscureText: AdminHomePageController.instance.isVisiblePassword.value,
                    onChanged: (value) {
                      LoginPageController.instance.password.value = value;
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.greenColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            icon: Icon(AdminHomePageController.instance.isVisiblePassword.value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              AdminHomePageController.instance.isVisiblePassword.value = !AdminHomePageController.instance.isVisiblePassword.value;
                            },
                          ),
                        ),
                        hintText: Strings.password,
                        labelText: Strings.enterPassword),
                  ),
                ),
                SizedBox(
                  height: 28,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      if (LoginPageController.instance.firstName.isEmpty) {
                        FlashMessage.showFlashMessage(
                            title: Strings.error, message: Strings.firstNameRequired, contentType: ContentType.failure, context: context);
                      } else if (LoginPageController.instance.lastName.isEmpty) {
                        FlashMessage.showFlashMessage(
                            title: Strings.error, message: Strings.lastNameRequired, contentType: ContentType.failure, context: context);
                      } else if (!LoginPageController.instance.email.contains(Strings.emailValidation)) {
                        FlashMessage.showFlashMessage(
                            title: Strings.error, message: Strings.invalidDevroninsEmail, contentType: ContentType.failure, context: context);
                      } else if (LoginPageController.instance.phoneNumber.isEmpty) {
                        FlashMessage.showFlashMessage(
                            title: Strings.error, message: Strings.phoneNumberRequired, contentType: ContentType.failure, context: context);
                      } else if (LoginPageController.instance.password.isEmpty) {
                        FlashMessage.showFlashMessage(
                            title: Strings.error, message: Strings.passwordRequired, contentType: ContentType.failure, context: context);
                      } else {
                        AuthController.instance.registerUser(
                            LoginPageController.instance.email.value.trim(),
                            LoginPageController.instance.password.value.trim(),
                            LoginPageController.instance.firstName.value,
                            LoginPageController.instance.lastName.value,
                            LoginPageController.instance.phoneNumber.value,
                            LoginPageController.instance.selectedDropdown.value,
                            context);
                      }
                      Get.back();
                    },
                    child: Container(
                        width: ResponsiveLayout.isSmallScreen(context) ? null : Get.width / 8,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              AppColors.greenColor,
                              AppColors.blueColor,
                            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Center(
                            child: Text(Strings.add.toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
