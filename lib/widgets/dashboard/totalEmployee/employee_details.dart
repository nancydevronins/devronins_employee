import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/technology_controller.dart';
import 'package:devroninsemployees/model/technology_model.dart';
import 'package:devroninsemployees/widgets/dashboard/add_new_employee_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/nemorphism_shadow.dart';
import '../../../utils/responsive_layout.dart';
import '../../LandingPage/submit_button.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveLayout.isSmallScreen(context) ? null : 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            profileImg,
            const SizedBox(
              height: 12,
            ),
            profileDetails,
            const SizedBox(
              height: 16,
            ),
            Obx(() => UserController.instance.isEditEnable.value
                ? SubmitBtn(
                    title: Strings.update,
                    isEnableIcon: false,
                    onTap: () {},
                  )
                : Container())
          ],
        ),
      ),
    );
  }

  Obx get profileDetails {
    return Obx(
      () => Stack(
        children: [
          AnimatedContainer(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              boxShadow: NeomorphismShape.boxShape,
              color: AppColors.white10,
            ),
            curve: Curves.ease,
            duration: const Duration(seconds: 1),
            height:
                UserController.instance.isEditEnable.value ? UserController.instance.height.value * 0.3 : UserController.instance.height.value * 0.28,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: UserController.instance.isEditEnable.value
                    ? [
                        TextField(
                          controller: UserController.instance.firstNameController..text = UserController.instance.users[index].firstName,
                          decoration: const InputDecoration(hintText: Strings.enterFirstName),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: UserController.instance.lastNameController..text = UserController.instance.users[index].lastName,
                          decoration: const InputDecoration(hintText: Strings.enterLastName),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: UserController.instance.emailController..text = UserController.instance.users[index].email,
                          decoration: const InputDecoration(hintText: Strings.enterEmail),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        TextField(
                          controller: UserController.instance.phoneController..text = UserController.instance.users[index].phone,
                          decoration: const InputDecoration(hintText: Strings.enterPhone),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                      ]
                    : [
                        name,
                        const SizedBox(
                          height: 12,
                        ),
                        userEmail,
                        const SizedBox(
                          height: 12,
                        ),
                        phone,
                        const SizedBox(
                          height: 12,
                        ),
                        designation,
                        const SizedBox(
                          height: 12,
                        ),
                        technology
                      ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
                onPressed: () {
                  UserController.instance.isEditEnable.value = !UserController.instance.isEditEnable.value;
                },
                icon: const Icon(Icons.edit_note_outlined)),
          ),
        ],
      ),
    );
  }

  Row get technology {
    String technologies = getTechnologiesName(UserController.instance.users[index].technology);
    return Row(
      children: [
        const Icon(Icons.developer_board_outlined),
        Text(
          technologies,
          style: const TextStyle(fontSize: 18),
        )
      ],
    );
  }

  Row get designation {
    return Row(
      children: [
        const Icon(Icons.business_center),
        const SizedBox(
          width: 8,
        ),
        Text(
          UserController.instance.users[index].designation,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Row get phone {
    return Row(
      children: [
        const Icon(Icons.phone_android_outlined),
        const SizedBox(
          width: 8,
        ),
        Text(
          UserController.instance.users[index].phone,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Row get userEmail {
    return Row(
      children: [
        const Icon(Icons.email_outlined),
        const SizedBox(
          width: 8,
        ),
        Text(
          UserController.instance.users[index].email,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Row get name {
    return Row(
      children: [
        const Icon(Icons.badge_outlined),
        const SizedBox(
          width: 8,
        ),
        Text(
          "${UserController.instance.users[index].firstName} ${UserController.instance.users[index].lastName}",
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  Container get profileImg {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: NeomorphismShape.boxShape,
        color: AppColors.white10,
      ),
      child: UserController.instance.users[index].profileUrl.isEmpty
          ? Stack(
              children: [
                Image.asset(
                  Images.placeholder,
                  height: Get.height * 0.35,
                ),
                Positioned(
                  right: 10,
                  child: Image.asset(
                    Images.edit,
                  ),
                )
              ],
            )
          : Image.network(UserController.instance.users[index].profileUrl),
    );
  }

  String getTechnologiesName(List<String> technology) {
    String technologiesName = '';
    for (var tec in TechnologyController.instance.technology) {
      for (var techs in technology) {
        if (techs.toString() == tec.id) {
          technologiesName = technologiesName + ", " + tec.technologyName!;
        }
      }
    }
    return technologiesName.replaceFirst(',', ' ');
  }
}
