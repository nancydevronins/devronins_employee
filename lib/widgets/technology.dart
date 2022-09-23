import 'package:devroninsemployees/controllers/technology_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../utils/custom_formfield_dialog.dart';
import '../utils/nemorphism_shadow.dart';
import '../utils/responsive_layout.dart';
import 'LandingPage/submit_button.dart';

class Technology extends StatelessWidget {
  const Technology({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: Get.height,
          width:
              ResponsiveLayout.isLargeScreen(context) ? Get.width * 0.90 : 340,
          decoration: BoxDecoration(
            color: AppColors.white10,
            borderRadius: BorderRadius.circular(25),
            boxShadow: NeomorphismShape.boxShape,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.technology.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    SubmitBtn(
                      title: Strings.addTechnology,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog(
                                title: Strings.addTechnology,
                                labelText: Strings.enterTechnology,
                                hintText: Strings.technology.toUpperCase(),
                              );
                            });
                      },
                      isEnableIcon: false,
                    )
                  ],
                ),
              ),
              divider(context),
              technologyListing(),
            ],
          ),
        ),
      ),
    );
  }

  Obx technologyListing() => Obx(
        () => Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(TechnologyController
                    .instance.technology[index].technologyName);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(TechnologyController
                          .instance.technology[index].technologyName
                          .toString()),
                      editDeleteAction()
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: TechnologyController.instance.technology.length),
        ),
      );

  Row editDeleteAction() => Row(
        children: [
          SubmitBtn(onTap: () {}, isEnableIcon: false, title: 'Edit'),
          SizedBox(width: 5),
          SubmitBtn(onTap: () {}, isEnableIcon: false, title: 'Delete'),
        ],
      );

  Container divider(BuildContext context) => Container(
        height: 2,
        width: ResponsiveLayout.isLargeScreen(context) ? Get.width * 0.90 : 340,
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
      );
}
