import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/modals/services_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../constants/colors.dart';
import '../constants/strings.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';
import '../widgets/sidebar.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
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

  bool isChecked = false;

  @override
  void initState() {
    AuthController.instance.designations();
    print(AuthController.instance.designationsListing.length);

    super.initState();
  }

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
        tiny: _addEmployeeForm(),
        largeTablet: _addEmployeeForm(),
        computer: _addEmployeeForm(),
        phone: _addEmployeeForm(),
        tablet: _addEmployeeForm(),
      ),
      drawer: SideBar(),
    );
  }

  Widget _addEmployeeForm() {
    return Center(
      child: Container(
        width: 700,
        height: 700,
        margin: const EdgeInsets.all(50),
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  TextWidget(
                    text: AppStrings.addEmployee,
                    textColor: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: Get.height * 0.020,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Align(
                alignment: Alignment.center,
                child: Form(
                  key: formKey,
                  child: SizedBox(
                    width: 300,
                    child: Column(
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
                        TextFormFieldWidget(
                          focusNodeCurrent: _passwordField,
                          focusNodeNext: _passwordField,
                          controller: passwordController,
                          obscureText: false,
                          textInputType: TextInputType.visiblePassword,
                          hintText: AppStrings.password,
                          functionValidate: (password) {
                            if (password!.isEmpty) {
                              return "please enter the Password";
                            } else if (password.length < 6) {
                              return "password should be greater then six";
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.030,
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
                                  .map((element) =>
                                      DropdownMenuItem<Designations>(
                                          value: element,
                                          child: Container(
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
                                    AuthController.instance.addEmployee(
                                        firstNameController.text.trim(),
                                        latNameController.text.trim(),
                                        emailController.text.trim(),
                                        passwordController.text.trim(),
                                        selectedDesignation!);
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
                                  Get.toNamed("/welcome");
                                },
                                style: ButtonStyle(
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(16)),
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xFFff8dbb55))),
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
              ),
            )
          ],
        )),
      ),
    );
  }
}
