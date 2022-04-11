import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/modals/services_modal.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';

class DesignationsListing extends StatefulWidget {
  const DesignationsListing({Key? key}) : super(key: key);

  @override
  _DesignationsListingState createState() => _DesignationsListingState();
}

class _DesignationsListingState extends State<DesignationsListing> {

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGroundColor,
      body: ResponsiveLayout(
        tiny: _designationsListing(),
        largeTablet: _designationsListing(),
        computer: _designationsListing(),
        phone: _designationsListing(),
        tablet: _designationsListing(),
      ),
    );
  }

  Widget _designationsListing() {
    return shadowContainer(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  openAddDesignationPopUp();
                },
                style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                child: TextWidget(
                  text: getString(context, "add_designation"),
                  textColor: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          const Divider(),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection(FirebaseConstants.table_designations).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData == false) {
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
                                Expanded(
                                  child: TextWidget(
                                    text: AuthController.instance.designationsListing[index].designationTitle,
                                    textColor: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: TextButton(
                                    onPressed: () {
                                      openAddDesignationPopUp(designation: AuthController.instance.designationsListing[index]);
                                    },
                                    child: Text(
                                      getString(context, "edit"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  child: TextButton(
                                    onPressed: () {
                                      AuthController.instance.deleteDesignation(AuthController.instance.designationsListing[index].docId);
                                    },
                                    child: Text(
                                      getString(context, "delete"),
                                    ),
                                  ),
                                  width: 100,
                                ),
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

  Future<void> openAddDesignationPopUp({Designations? designation}) {
    TextEditingController controller;
    if (designation != null) {
      controller = TextEditingController(text: designation.designationTitle);
    } else {
      controller = TextEditingController();
    }
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setState) => AlertDialog(
          title: Text(
            getString(context, "designation"),
            style: appSemiBoldTextStyle(fontSize: 16),
          ),
          content: Form(
              key: formKey,
              child: SizedBox(
                width: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormFieldWidget(
                        hintText: getString(context, "enter_designation_title"),
                        controller: controller,
                        obscureText: false,
                        textInputType: TextInputType.text,
                        textStyle: appRegularTextStyle(fontSize: 16),
                        functionValidate: (designation) {
                          if (designation!.isEmpty) {
                            return getString(context, "validation_designation");
                          }
                          return null;
                        }),
                    space(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              AuthController.instance.addEditDesignation(designation?.docId, controller.text.trim());
                              controller.clear();
                              Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                          child: Text(
                            getString(context, "save"),
                            style: appRegularTextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColor.appGreen)),
                          child: Text(
                            getString(context, "cancel"),
                            style: appRegularTextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
