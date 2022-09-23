import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/controllers/technology_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../constants/colors.dart';
import '../constants/images.dart';
import '../model/technology_model.dart';
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
        dropdownDesignations,
        const Text(Strings.selectTechnology),
        dropDownTechnology
      ],
    );
  }

  Obx selectProfilePic() {
    return Obx(() => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: NeomorphismShape.boxShape,
            color: AppColors.white10,
          ),
          child: LoginPageController.instance.profileUrl.value.isEmpty
              ? LoginPageController.instance.isLoading.value
                  ? const Center(child: WaveLoading())
                  : Stack(
                      children: [
                        Image.asset(
                          Images.placeholder,
                          height: Get.height * 0.35,
                        ),
                        Positioned(
                          right: 0,
                          top: 30,
                          child: InkWell(
                            onTap: () {
                              LoginPageController.instance.pickAndStoreUserImageInDb();
                            },
                            child: Image.asset(
                              Images.edit,
                            ),
                          ),
                        )
                      ],
                    )
              : Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: NeomorphismShape.boxShape,
                    color: AppColors.white10,
                  ),
                  child: Image.network(LoginPageController.instance.profileUrl.value)),
        ));
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

  Obx get dropDownTechnology {
    return Obx(
      () => MultiSelectDialogField(
        items: TechnologyController.instance.technology.map((e) => MultiSelectItem<TechnologyModel>(e, e.technologyName!)).toList(),
        validator: (values) {
          if (values == null || values.isEmpty) {
            return "Please select service(s)";
          }
          return null;
        },
        initialValue: LoginPageController.instance.selectedTechnology,
        title: const Text(
          "Select Services",
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
          items: TechnologyController.instance.technology.map((e) => MultiSelectItem<TechnologyModel>(e, e.technologyName.toString())).toList(),
          onTap: (value) {
            TechnologyController.instance.removeSelectedValue(value);
          },
        ),
        onConfirm: (results) {
          LoginPageController.instance.selectedTechnology = results as List<TechnologyModel>;
          print(LoginPageController.instance.selectedTechnology);
        },
      ),
    );
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
