import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../utils/nemorphism_shadow.dart';
import '../utils/wave_loading.dart';

class ProfileSetup extends StatelessWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        setUpYourProfile(context),
        selectProfilePic(),
        firstNameField,
        lastNameField,
        phoneNumberField,
        const Text(Strings.selectDesignation),
        dropdownDesignations
      ],
    );
  }

  Obx selectProfilePic() {
    return Obx(
      () => LoginPageController.instance.profileUrl.value.isEmpty
          ? LoginPageController.instance.isLoading.value
              ? Center(child: WaveLoading())
              : Container(
                  height: Get.height * 0.35,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: NeomorphismShape.boxShape,
                    color: AppColors.white10,
                  ),
                  child: InkWell(
                    onTap: () {
                      LoginPageController.instance.pickAndStoreUserImageInDb();
                    },
                    child: Image.asset(
                      Images.placeholder,
                    ),
                  ),
                )
          : Container(
              width: Get.width,
              height: Get.height * 0.35,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: NeomorphismShape.boxShape,
                color: AppColors.white10,
              ),
              child: Image.network(LoginPageController.instance.profileUrl.value)),
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
                  .map((item) => item == Strings.selectDesignation
                      ? DropdownMenuItem(
                          value: item,
                          enabled: false,
                          child: Text(
                            item,
                          ),
                        )
                      : DropdownMenuItem(
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
        decoration: const InputDecoration(contentPadding: EdgeInsets.all(12), border: InputBorder.none, hintText: Strings.firstName),
      ),
    );
  }

  Padding setUpYourProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        Strings.setUpYourProfile,
        style: TextStyle(fontSize: ResponsiveLayout.isLargeScreen(context) && ResponsiveLayout.isMediumScreen(context) ? 20 : 16),
      ),
    );
  }
}
