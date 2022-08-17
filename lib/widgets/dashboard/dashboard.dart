import 'dart:ui';

import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/controllers/user_controller.dart';
import 'package:devroninsemployees/pages/calender_page.dart';
import 'package:devroninsemployees/routes/routes.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/dashboard/add_new_employee_form.dart';
import 'package:devroninsemployees/widgets/dashboard/calender.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Obx(
      () => GridView.count(
        padding: const EdgeInsets.all(30),
        crossAxisSpacing: 30,
        mainAxisSpacing: 10,
        crossAxisCount: ResponsiveLayout.isSmallScreen(context) ? 1 : 3,
        children: <Widget>[
          totalEmployee(context),
          addNewMember(context),
          calender(context),
        ],
      ),
    ));
  }

  InkWell calender(context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onHover: (value) {
        AdminHomePageController.instance.isHover3.value = value;
      },
      onTap: () {
        Get.toNamed(RoutesClass.calenderPage);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greenColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.calendar_month,
                  size: 40,
                  color: AdminHomePageController.instance.isHover3.value ? Colors.black54 : Colors.black,
                ),
                Text(
                  Strings.calender,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: AdminHomePageController.instance.isHover3.value ? Colors.black54 : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell addNewMember(context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) {
              return AddNewEmployeeForm();
            });
      },
      onHover: (value) {
        AdminHomePageController.instance.isHover2.value = value;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.greenColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add_outlined, size: 50, color: AdminHomePageController.instance.isHover2.value ? Colors.black54 : Colors.black),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Strings.addNewMember,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: AdminHomePageController.instance.isHover2.value ? Colors.black54 : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  totalEmployee(context) {
    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {},
      onHover: (value) {
        AdminHomePageController.instance.isHover1.value = value;
      },
      child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.greenColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.badge_outlined,
                    size: 50,
                    color: AdminHomePageController.instance.isHover1.value ? Colors.black54 : Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Strings.totalEmployee} ${UserController.instance.users.length}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: AdminHomePageController.instance.isHover1.value ? Colors.black54 : Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
