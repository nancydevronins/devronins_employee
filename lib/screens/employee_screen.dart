import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/widgets/resourses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../modals/services_modal.dart';
import '../responsive_layout.dart';
import '../widgets/sidebar.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final _multiSelectKey = GlobalKey<FormFieldState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController latNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode _firstNameField = new FocusNode();
  FocusNode _lastNameField = new FocusNode();
  FocusNode _passwordField = new FocusNode();
  FocusNode _emailField = new FocusNode();
  Designations? selectedDesignation;
  String? docId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGroundColor,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) ||
                ResponsiveLayout.isTinyHeightLimit(context)
            ? Container()
            : AppBar()),
      ),
      body: ResponsiveLayout(
        tiny: _employeeDetails(),
        largeTablet: _employeeDetails(),
        computer: _employeeDetails(),
        phone: _employeeDetails(),
        tablet: _employeeDetails(),
      ),
      drawer: SideBar(),
    );
  }

  Widget _employeeDetails() {
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
                const TextWidget(
                    text: "Employees",
                    textColor: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600),
                TextButton(
                    onPressed: () {
                      Get.toNamed("/addemployee");
                    },
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFff8dbb55))),
                    child: const TextWidget(
                      text: "Add Employee",
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                TextWidget(
                  text: "Name",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                TextWidget(
                  text: "Email",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                TextWidget(
                  text: "Designation",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
                TextWidget(
                  text: "Actions",
                  textColor: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                ),
              ],
            ),
          ),
          Divider(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: AuthController.firebaseFirestore
                    .collection('employees')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView.separated(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                text: snapshot.data!.docs[index]['firstName']
                                    .toString(),
                                textColor: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                              TextWidget(
                                text: snapshot.data!.docs[index]['email']
                                    .toString(),
                                textColor: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                              TextWidget(
                                text: snapshot.data!.docs[index]['designation']
                                    .toString(),
                                textColor: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        firstNameController.text = snapshot
                                            .data!.docs[index]['firstName'];
                                        latNameController.text = snapshot
                                            .data!.docs[index]['lastName'];
                                        emailController.text =
                                            snapshot.data!.docs[index]['email'];
                                        docId = snapshot.data!.docs[index].id;

                                        openEditEmployeeData();
                                      },
                                      child: Text(AppStrings.edit)),
                                  TextButton(
                                      onPressed: () {
                                        AuthController.instance
                                            .deleteEmployeeData(
                                                snapshot.data!.docs[index].id);
                                      },
                                      child: Text(AppStrings.delete)),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Future<void> openEditEmployeeData() {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (ctx, setState) => AlertDialog(
                title: const Text("Edit Employees"),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormFieldWidget(
                        focusNodeCurrent: _firstNameField,
                        focusNodeNext: _lastNameField,
                        controller: firstNameController,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        hintText: AppStrings.firstName,
                        functionValidate: (name) {
                          if (name!.isEmpty) {
                            return "please enter the First Name";
                          }
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),
                      TextFormFieldWidget(
                        focusNodeCurrent: _lastNameField,
                        focusNodeNext: _emailField,
                        controller: latNameController,
                        obscureText: false,
                        textInputType: TextInputType.name,
                        hintText: AppStrings.lastName,
                        functionValidate: (name) {
                          if (name!.isEmpty) {
                            return "please enter the Last Name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),
                      TextFormFieldWidget(
                        focusNodeCurrent: _emailField,
                        focusNodeNext: _passwordField,
                        controller: emailController,
                        obscureText: false,
                        textInputType: TextInputType.emailAddress,
                        hintText: AppStrings.email,
                        functionValidate: (email) {
                          const pattern1 =
                              r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                          final regExp = RegExp(pattern1);
                          if (email!.isEmpty) {
                            return "please enter the Email";
                          } else if (!regExp.hasMatch(email)) {
                            return "please enter the valid email address";
                          }
                        },
                      ),
                      SizedBox(
                        height: Get.height * 0.020,
                      ),
                      Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: DropdownButtonFormField<Designations>(
                            validator: (value) =>
                                value == null ? 'field required' : null,
                            isExpanded: false,
                            hint: Container(
                              width: 150, //and here
                              child: const Text(
                                "Select Item Type",
                                style: TextStyle(color: Colors.grey),
                                textAlign: TextAlign.end,
                              ),
                            ),
                            items: AuthController.instance.designationsListing
                                .map(
                                    (element) => DropdownMenuItem<Designations>(
                                        value: element,
                                        child: SizedBox(
                                            width: 150,
                                            child: Text(
                                              element.designationTitle,
                                              textAlign: TextAlign.end,
                                            ))))
                                .toList(),
                            value: selectedDesignation,
                            onChanged: (value) {
                              setState(() {
                                selectedDesignation = value!;
                              });
                            },
                          )),
                      SizedBox(
                        height: Get.height * 0.030,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthController.instance.updateEmployeeData(
                                      firstNameController.text.trim(),
                                      latNameController.text.trim(),
                                      emailController.text.trim(),
                                      docId!);
                                  Navigator.pop(context);
                                }
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(16)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xFFff8dbb55))),
                              child: TextWidget(
                                text: AppStrings.save,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.all(16)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xffff8dbb55))),
                              child: TextWidget(
                                text: AppStrings.cancel,
                                textColor: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
