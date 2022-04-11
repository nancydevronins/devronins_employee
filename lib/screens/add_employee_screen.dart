import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/modals/services_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController latNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _firstNameField = FocusNode();
  final FocusNode _lastNameField = FocusNode();
  final FocusNode _passwordField = FocusNode();
  final FocusNode _emailField = FocusNode();

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
        preferredSize: const Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) || ResponsiveLayout.isTinyHeightLimit(context) ? Container() : AppBar()),
      ),
      body: ResponsiveLayout(
        tiny: _addEmployeeForm(),
        largeTablet: _addEmployeeForm(),
        computer: _addEmployeeForm(),
        phone: _addEmployeeForm(),
        tablet: _addEmployeeForm(),
      ),
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
                    text: getString(context, "add_employee"),
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
                          hintText: getString(context, "first_name"),
                          functionValidate: (name) {
                            if (name!.isEmpty) {
                              return getString(context, "validation_first_name");
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
                          hintText: getString(context, "last_name"),
                          functionValidate: (name) {
                            if (name!.isEmpty) {
                              return getString(context, "validation_last_name");
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
                          hintText: getString(context, "email"),
                          functionValidate: (email) {
                            if (!isValidEmail(email)) {
                              return getString(context, "validation_email");
                            }
                            return null;
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
                          hintText: getString(context, "password"),
                          functionValidate: (password) {
                            if (isValidPasswordLength(password)) {
                              return getString(context, "validation_password_length");
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.030,
                        ),
                        Container(
                            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: DropdownButtonFormField<Designations>(
                              validator: (value) => value == null ? 'field required' : null,
                              isExpanded: false,
                              hint: const SizedBox(
                                width: 150, //and here
                                child: Text(
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
                                        ),
                                      ),
                                    ),
                                  )
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
                                    AuthController.instance.addEmployee(firstNameController.text.trim(), latNameController.text.trim(), emailController.text.trim(), passwordController.text.trim(), selectedDesignation!);
                                  }
                                },
                                style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(const Color(0xFFff8dbb55))),
                                child: TextWidget(
                                  text: getString(context, "save"),
                                  textColor: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.0,
                                )),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed("/welcome");
                                },
                                style: ButtonStyle(padding: MaterialStateProperty.all(const EdgeInsets.all(16)), backgroundColor: MaterialStateProperty.all(const Color(0xFFff8dbb55))),
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
