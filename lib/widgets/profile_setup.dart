import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        setUpYourProfile(context),
        firstNameField,
        lastNameField,
        phoneNumberField,
        const Text(Strings.selectDesignation),
        dropdownDesignations
      ],
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
          child: DropdownButtonFormField(
              style: TextStyle(color: Colors.grey.shade700),
              decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.all(12)),
              onChanged: (newValue) {
                LoginPageController.instance.dropDownValueChange(newValue.toString());
              },
              value: LoginPageController.instance.selectedDropdown.value,
              items: LoginPageController.instance.dropdownTextList
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                        ),
                      ))
                  .toList()),
        ));
  }

  Container get phoneNumberField {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextField(
        onChanged: (value) {
          LoginPageController.instance.phoneNumber.value = value;
        },
        decoration: InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.phoneNumber),
      ),
    );
  }

  Container get lastNameField {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextField(
        onChanged: (value) {
          LoginPageController.instance.lastName.value = value;
        },
        decoration: InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.lastName),
      ),
    );
  }

  Container get firstNameField {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.grey.withOpacity(0.2),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: TextField(
        onChanged: (value) {
          LoginPageController.instance.firstName.value = value;
        },
        decoration: InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.firstName),
      ),
    );
  }

  Text setUpYourProfile(BuildContext context) {
    return Text(
      Strings.setUpYourProfile,
      style: TextStyle(fontSize: ResponsiveLayout.isLargeScreen(context) && ResponsiveLayout.isMediumScreen(context) ? 20 : 16),
    );
  }
}
