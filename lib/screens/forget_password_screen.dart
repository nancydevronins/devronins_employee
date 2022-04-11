import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGroundColor,
      body: ResponsiveLayout(
          tiny: container(),
          phone: container(),
          tablet: container(),
          largeTablet: container(),
          computer: container()),
    );
  }

  Widget container() {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.all(50),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 100),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextWidget(
                    text: getString(context, "login"),
                    textColor: AppColor.appBlue,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: getString(context, "login_sub_heading"),
                    textColor: AppColor.appBlue,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextFormFieldWidget(
                      focusNodeCurrent: emailFocus,
                      focusNodeNext: emailFocus,
                      controller: emailController,
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      hintText: "Email address:",
                      functionValidate: (email) {
                        const pattern1 =
                            r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
                        final regExp1 = RegExp(pattern1);
                        if (email!.isEmpty) {
                          return "please enter the email address";
                        } else if (!regExp1.hasMatch(email)) {
                          return "please enter the valid email";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 500,
                    child: TextButton(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(24)),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFFff8dbb55)),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          AuthController.instance.sendResetPasswordEmail(
                              emailController.text.trim());
                        }
                      },
                      child: const TextWidget(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        text: 'Reset Password',
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
