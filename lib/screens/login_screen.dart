import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/screens/signup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/painting.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  late bool _visiblePassword = true;

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
                    text: AppStrings.logIn,
                    textColor: Color(0xFFff52a3d8),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextWidget(
                    text: AppStrings.logInSubHeading,
                    textColor: Color(0xFFff52a3d8),
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
                      focusNodeNext: passwordFocus,
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
                  SizedBox(
                    width: 500,
                    child: TextFormFieldWidget(
                      focusNodeCurrent: passwordFocus,
                      focusNodeNext: passwordFocus,
                      controller: passwordController,
                      obscureText: !_visiblePassword,
                      textInputType: TextInputType.visiblePassword,
                      hintText: "Password:",
                      functionValidate: (password) {
                        if (password!.isEmpty) {
                          return "plaese enter the password";
                        } else if (password.length < 6) {
                          return "Password should be greater then six";
                        }
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _visiblePassword = !_visiblePassword;
                          });
                        },
                        child: Icon(
                          _visiblePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 500,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const TextWidget(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          text: 'Forget Password',
                          textColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
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
                          AuthController.instance.loginUser(
                              emailController.text.trim(),
                              passwordController.text.trim());
                        }
                      },
                      child: const TextWidget(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        text: 'Submit',
                        textColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 500,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Get.to(const SignupScreen());
                        },
                        child: const TextWidget(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          text: 'Create Account',
                          textColor: Color(0xFFff52a3d8),
                        ),
                      ),
                    ),
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
