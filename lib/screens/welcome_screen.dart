import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/responsive_layout.dart';
import 'package:devronins_employeeee/widgets/resourses.dart';
import 'package:devronins_employeeee/widgets/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    AuthController.instance.designations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context)
            ? Container()
            : AppBar(
                title: const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    "DevRonins",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(top: 30, right: 30),
                    child: PopupMenuButton(
                        icon: Icon(Icons.person),
                        itemBuilder: (context) => [
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/userProfile');
                                  },
                                  child: const Text(
                                    "Profile",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                value: 1,
                              ),
                              PopupMenuItem(
                                child: TextButton(
                                  onPressed: () {
                                    AuthController.instance.logOut();
                                  },
                                  child: const Text(
                                    "Log Out",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                value: 2,
                              )
                            ]),
                  )
                ],
              )),
      ),
      backgroundColor: AppColor.scaffoldBackGroundColor,
      body: Center(
        child: InkWell(
          onTap: () {
            Get.toNamed("/employee");
          },
          child: Container(
            height: Get.height * 0.3,
            width: Get.width * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: StreamBuilder<QuerySnapshot>(
                stream: AuthController.firebaseFirestore
                    .collection("employees")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: const CircularProgressIndicator());
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Employees",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data!.docs.length.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
      drawer: const SideBar(),
    );
  }
}
