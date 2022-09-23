import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/LandingPage/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String hintText;
  final String labelText;
  const CustomDialog(
      {Key? key,
      required this.title,
      required this.hintText,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white10,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      content: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: SizedBox(
          width: ResponsiveLayout.isSmallScreen(context) ? null : 400,
          child: TextField(
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.greenColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                hintText: hintText,
                labelText: labelText),
          ),
        ),
      ),
      actions: [
        InkWell(
          onTap: () {},
          child: Container(
            width:
                ResponsiveLayout.isSmallScreen(context) ? null : Get.width / 15,
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
            ),
          ),
        )
      ],
    );
  }
}
