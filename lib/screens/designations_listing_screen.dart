import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';
import '../widgets/sidebar.dart';

class DesignationsListing extends StatefulWidget {
  const DesignationsListing({Key? key}) : super(key: key);

  @override
  _DesignationsListingState createState() => _DesignationsListingState();
}

class _DesignationsListingState extends State<DesignationsListing> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController addDesignationController = TextEditingController();
  String? docId;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) || ResponsiveLayout.isTinyHeightLimit(context) ? Container() : AppBar()),
      ),
      body: ResponsiveLayout(
        tiny: _designationsListing(),
        largeTablet: _designationsListing(),
        computer: _designationsListing(),
        phone: _designationsListing(),
        tablet: _designationsListing(),
      ),
      drawer: const SideBar(),
    );
  }

  Widget _designationsListing() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: getString(context, "designations"), textColor: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600),
                TextButton(
                    onPressed: () {
                      openAddDesignationPopUp();
                    },
                    style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                    child: TextWidget(
                      text: getString(context, "add_designation"),
                      textColor: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16.0,
                    )),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextWidget(
                  text: getString(context, "title"),
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                TextWidget(
                  text: getString(context, "actions"),
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ],
            ),
          ),
          const Divider(),
          StreamBuilder(builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextWidget(
                              text: AuthController.instance.designationsListing[index].designationTitle,
                              textColor: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    designationController.text = AuthController.instance.designationsListing[index].designationTitle;
                                    docId = AuthController.instance.designationsListing[index].docId;
                                    openEditPopUp();
                                  },
                                  child: Text(
                                    getString(context, "edit"),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    AuthController.instance.deleteDesignation(AuthController.instance.designationsListing[index].docId);
                                  },
                                  child: Text(
                                    getString(context, "delete"),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: AuthController.instance.designationsListing.length),
              );
            }
          })
        ],
      ),
    );
  }

  Future<void> openAddDesignationPopUp() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => StatefulBuilder(
            builder: (ctx, setState) => AlertDialog(
                  title: Text(getString(context, "designation_title")),
                  content: Form(
                      key: formKey,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormFieldWidget(
                                hintText: getString(context, "designation_title"),
                                controller: addDesignationController,
                                obscureText: false,
                                textInputType: TextInputType.text,
                                functionValidate: (designation) {
                                  if (designation!.isEmpty) {
                                    return getString(context, "validation_designation");
                                  }
                                }),
                            SizedBox(
                              height: Get.height * 0.020,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        AuthController.instance.addDesignation(addDesignationController.text.trim());
                                        Navigator.pop(context);
                                        addDesignationController.clear();
                                      }
                                    },
                                    style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                                    child: TextWidget(
                                      text: getString(context, "save"),
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                                    child: TextWidget(
                                      text: getString(context, "cancel"),
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )),
                )));
  }

  Future<void> openEditPopUp() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (ctx) => StatefulBuilder(
            builder: (ctx, setState) => AlertDialog(
                  title: Text(getString(context, "designation_title")),
                  content: Form(
                      key: formKey,
                      child: SizedBox(
                        width: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormFieldWidget(
                                hintText: getString(context, "designation_title"),
                                controller: designationController,
                                obscureText: false,
                                textInputType: TextInputType.text,
                                functionValidate: (designation) {
                                  if (designation!.isEmpty) {
                                    return getString(context, "validation_designation");
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: Get.height * 0.020,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        AuthController.instance.updateDesignations(designationController.text.trim(), docId!);
                                        Navigator.pop(context);
                                      }
                                    },
                                    style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                                    child: TextWidget(
                                      text: getString(context, "save"),
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                                    child: TextWidget(
                                      text: getString(context, "cancel"),
                                      textColor: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                    )),
                              ],
                            ),
                          ],
                        ),
                      )),
                )));
  }
}
