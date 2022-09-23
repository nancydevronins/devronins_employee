import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/controllers/designation_controller.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/model/designation_model.dart';
import 'package:devroninsemployees/utils/flash_message.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/profile_setup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import '../../constants/strings.dart';
import '../../controllers/technology_controller.dart';
import '../../model/technology_model.dart';
import '../../utils/nemorphism_shadow.dart';

class AddNewEmployeeForm extends StatelessWidget {
  const AddNewEmployeeForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white10,
      title: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              Strings.addNewMember,
              style: TextStyle(
                  fontSize: ResponsiveLayout.isSmallScreen(context) ? 16 : 24),
            ),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.clear))
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
                const ProfileSetup().selectProfilePic(),
                const SizedBox(
                  height: 24,
                ),
                firstNameField,
                const SizedBox(
                  height: 24,
                ),
                lastNameField,
                const SizedBox(
                  height: 24,
                ),
                emailField,
                const SizedBox(
                  height: 24,
                ),
                phoneNumberField,
                const SizedBox(
                  height: 8,
                ),
                dropdownDesignations,
                const SizedBox(
                  height: 8,
                ),
                dropDownTechnology,
                const SizedBox(
                  height: 8,
                ),
                passwordField,
                const SizedBox(
                  height: 28,
                ),
                addButton(context),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Obx get dropDownTechnology {
    return Obx(
      () => MultiSelectDialogField(
        dialogHeight: 300,
        dialogWidth: 30,
        items: TechnologyController.instance.technology
            .map((e) => MultiSelectItem<TechnologyModel>(e, e.technologyName!))
            .toList(),
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "Please select service(s)";
          }
          return null;
        },
        initialValue: LoginPageController.instance.selectedTechnology,
        title: const Text(
          "Select Technology",
          style: TextStyle(color: Colors.blue),
        ),
        selectedColor: Colors.blue,
        selectedItemsTextStyle: const TextStyle(fontSize: 14),
        backgroundColor: Colors.white,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            color: Colors.blue,
            width: 2,
          ),
        ),
        buttonIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
        ),
        buttonText: const Text(
          "Select Technology",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        chipDisplay: MultiSelectChipDisplay(
          chipColor: Colors.grey,
          textStyle: const TextStyle(fontSize: 14, color: Colors.red),
          items: TechnologyController.instance.technology
              .map((e) => MultiSelectItem<TechnologyModel>(
                  e, e.technologyName.toString()))
              .toList(),
          onTap: (value) {
            TechnologyController.instance.removeSelectedValue(value);
          },
        ),
        onConfirm: (results) {
          LoginPageController.instance.selectedTechnology =
              results as List<TechnologyModel>;
          print(LoginPageController.instance.selectedTechnology);
        },
      ),
    );
  }

  Align addButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          if (LoginPageController.instance.profileUrl.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.profilePicRequired,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.firstName.isEmpty) {
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
          } else if (!LoginPageController.instance.email
              .contains(Strings.emailValidation)) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.invalidDevroninsEmail,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.phoneNumber.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.phoneNumberRequired,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.selectedDropdown.value ==
              Strings.selectDesignation) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.selectDesignation,
                contentType: ContentType.failure,
                context: context);
          } else if (LoginPageController.instance.password.isEmpty) {
            FlashMessage.showFlashMessage(
                title: Strings.error,
                message: Strings.passwordRequired,
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
        },
        child: Container(
            width:
                ResponsiveLayout.isSmallScreen(context) ? null : Get.width / 8,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Center(
                child: Text(Strings.add.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold)),
              ),
            )),
      ),
    );
  }

  Obx get passwordField {
    return Obx(
      () => TextField(
        controller: LoginPageController.instance.passwordController
          ..text = LoginPageController.instance.password.value,
        obscureText: LoginPageController.instance.isVisiblePassword.value,
        onChanged: (value) {
          LoginPageController.instance.passwordChange(value.obs);
        },
        decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.greenColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(LoginPageController.instance.isVisiblePassword.value
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  LoginPageController.instance.isVisiblePassword.value =
                      !LoginPageController.instance.isVisiblePassword.value;
                },
              ),
            ),
            hintText: Strings.password,
            labelText: Strings.enterPassword),
      ),
    );
  }

  TextField get phoneNumberField {
    return TextField(
      controller: LoginPageController.instance.phoneController
        ..text = LoginPageController.instance.phoneNumber.value,
      onChanged: (value) {
        LoginPageController.instance.phoneNumber.value = value;
      },
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: Strings.phoneNumber,
          labelText: Strings.enterPhone),
    );
  }

  TextField get emailField {
    return TextField(
      controller: LoginPageController.instance.emailController
        ..text = LoginPageController.instance.email.value,
      onChanged: (value) {
        LoginPageController.instance.email.value = value;
      },
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: Strings.email,
          labelText: Strings.enterEmail),
    );
  }

  TextField get lastNameField {
    return TextField(
      controller: LoginPageController.instance.lastNameController
        ..text = LoginPageController.instance.lastName.value,
      onChanged: (value) {
        LoginPageController.instance.lastName.value = value;
      },
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: Strings.lastName,
          labelText: Strings.enterLastName),
    );
  }

  TextField get firstNameField {
    return TextField(
      controller: LoginPageController.instance.firstNameController
        ..text = LoginPageController.instance.firstName.value,
      onChanged: (value) {
        LoginPageController.instance.firstName.value = value;
      },
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greenColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          hintText: Strings.firstName,
          labelText: Strings.enterFirstName),
    );
  }

  Obx get dropdownDesignations {
    return Obx(() => Container(
          margin: const EdgeInsets.only(top: 16, bottom: 16),
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.grey.withOpacity(0.2),
          ),
          child: DropdownButtonFormField<DesignationModel>(
              style: TextStyle(color: Colors.grey.shade700),
              decoration: const InputDecoration(
                  border: InputBorder.none, contentPadding: EdgeInsets.all(12)),
              onChanged: (newValue) {
                LoginPageController.instance
                    .dropDownValueChange(newValue.toString());
              },
              hint: const SizedBox(
                width: 150, //and here
                child: Text(
                  "Select Designation",
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.end,
                ),
              ),
              value: LoginPageController.instance.designation,
              items: DesignationController.instance.designations
                  .map((designation) => DropdownMenuItem<DesignationModel>(
                        value: designation,
                        child: SizedBox(
                          width: 150,
                          child: Text(
                            designation.designationName!,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ))
                  .toList()),
        ));
  }
}
