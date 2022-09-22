import 'package:auto_animated/auto_animated.dart';
import 'package:devroninsemployees/constants/strings.dart';
import 'package:devroninsemployees/controllers/technology_controller.dart';
import 'package:devroninsemployees/controllers/user_controller.dart';
import 'package:devroninsemployees/utils/wave_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../controllers/auth_controller.dart';
import '../widgets/dashboard/totalEmployee/total_employee.dart';

class TotalEmployeesPage extends StatelessWidget {
  const TotalEmployeesPage({Key? key}) : super(key: key);

  animationItemBuilder(
    Widget Function(int index) child, {
    EdgeInsets padding = EdgeInsets.zero,
  }) =>
      (
        BuildContext context,
        int index,
        Animation<double> animation,
      ) =>
          FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, -0.1),
                end: Offset.zero,
              ).animate(animation),
              child: Padding(
                padding: padding,
                child: child(index),
              ),
            ),
          );
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "${Strings.totalEmployee} ${UserController.instance.users.length}",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AuthController.instance.logout();
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ))
          ],
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  AppColors.greenColor,
                  AppColors.blueColor,
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
          ),
        ),
        body: UserController.instance.users.isNotEmpty
            ? LiveList(
                showItemInterval: Duration(milliseconds: 150),
                showItemDuration: Duration(milliseconds: 350),
                padding: EdgeInsets.all(20),
                reAnimateOnVisibility: true,
                scrollDirection: Axis.vertical,
                itemCount: UserController.instance.users.length,
                itemBuilder: animationItemBuilder((index) => TotalEmployee(
                      index: index,
                    )))
            : const Center(child: Text("No data found!"))));
  }
}
