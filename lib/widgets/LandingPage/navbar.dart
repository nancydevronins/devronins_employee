import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/constants/images.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/responsive_layout.dart';

class NavBar extends StatelessWidget {
  final navLinks = ["Home", "Products", "Features", "Contact"];

  List<Widget> navItem() {
    return navLinks.map((text) {
      return Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          text,
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(colors: [
                      AppColors.greenColor,
                      AppColors.blueColor,
                    ], begin: Alignment.bottomRight, end: Alignment.topLeft)),
                child: const Center(
                  child: Text(Strings.appNameShortcut, style: TextStyle(fontSize: 30, color: Colors.white)),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Image.asset(
                Images.devRonins,
                height: 26,
              )
            ],
          ),
          if (!ResponsiveLayout.isSmallScreen(context))
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              ...navItem(),
              InkWell(
                  onTap: () {
                    Get.toNamed(RoutesClass.loginPage);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20),
                    width: 120,
                    height: 40,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [
                          AppColors.greenColor,
                          AppColors.blueColor,
                        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
                    child: const Center(
                      child: Text(Strings.login,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            letterSpacing: 1,
                          )),
                    ),
                  ))
            ])
          else
            const Icon(
              Icons.menu,
              size: 26,
            )
        ],
      ),
    );
  }
}
