import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../responsive_layout.dart';
import '../widgets/resourses.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState>? formKey;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  late bool _visiblePassword = false;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackGroundColor,
      body: ResponsiveLayout(tiny: container(), phone: container(), tablet: container(), largeTablet: container(), computer: container()),
    );
  }

  Widget container() {
    return Center(
      child: shadowContainer(
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
                      focusNodeNext: passwordFocus,
                      controller: emailController,
                      obscureText: false,
                      textInputType: TextInputType.emailAddress,
                      hintText: getString(context, "email"),
                      errorText: emailError,
                      onChanged: (value) {
                        if (emailError != null && value.toString().isNotEmpty) {
                          setState(() {
                            emailError = null;
                          });
                        }
                      },
                      functionValidate: (email) {
                        if (!isValidEmail(email)) {
                          return getString(context, "validation_email");
                        }
                        return null;
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
                      hintText: getString(context, "password"),
                      errorText: passwordError,
                      onChanged: (value) {
                        if (passwordError != null && value.toString().isNotEmpty) {
                          setState(() {
                            passwordError = null;
                          });
                        }
                      },
                      functionValidate: (password) {
                        if (!isValidPasswordLength(password)) {
                          return getString(context, "validation_password_length");
                        } else {
                          return null;
                        }
                      },
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _visiblePassword = !_visiblePassword;
                          });
                        },
                        child: Icon(
                          _visiblePassword ? Icons.visibility_off : Icons.visibility,
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
                        onPressed: () {
                          openForgotPasswordDialog();
                        },
                        child: TextWidget(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          text: getString(context, "forgot_password"),
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
                        padding: MaterialStateProperty.all(const EdgeInsets.all(24)),
                        backgroundColor: MaterialStateProperty.all(AppColor.appGreen),
                      ),
                      onPressed: () async {
                        if (formKey?.currentState?.validate() == true) {
                          progressDialog(true, context);
                          var result = await AuthController.instance.loginUser(emailController.text.trim(), passwordController.text.trim());
                          progressDialog(false, context);
                          if (result is FirebaseAuthException) {
                            handleFirebaseExceptions(result);
                          } else if (result is UserCredential && result.user != null) {
                            showTopSnackBar(context, message: "Logged In Successfully!");
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()), ModalRoute.withName('/'));
                          }
                        }
                      },
                      child: TextWidget(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        text: getString(context, "submit"),
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

  String? emailError;
  String? passwordError;

  void handleFirebaseExceptions(FirebaseAuthException error) {
    switch (error.code) {
      case "user-not-found":
        setState(() {
          emailError = getString(context, "user_not_found");
        });
        break;
      case "wrong-password":
        setState(() {
          passwordError = getString(context, "wrong-password");
        });
        break;
      default:
        print(error.toString());
        break;
    }
  }

  void openForgotPasswordDialog() {
    final TextEditingController emailController = TextEditingController();
    String? emailError;
    bool sendEmail = false;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                getString(context, "forgot_password"),
                style: appSemiBoldTextStyle(fontSize: 16),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    getString(context, "enter_email_for_forgot_password"),
                    style: appRegularTextStyle(fontSize: 12, color: AppColor.color818181),
                  ),
                  space(height: 4),
                  TextFormFieldWidget(
                    controller: emailController,
                    obscureText: false,
                    textInputType: TextInputType.emailAddress,
                    hintText: getString(context, "email"),
                    errorText: emailError,
                    textStyle: appRegularTextStyle(fontSize: 16),
                    onChanged: (value) {
                      if (emailError != null && value.toString().isNotEmpty) {
                        print('Entered value: $value');
                        setState(() {
                          print('Entered value****: $value');
                          emailError = null;
                        });
                      }
                    },
                    functionValidate: (email) {
                      if (!isValidEmail(email)) {
                        return getString(context, "validation_email");
                      }
                      return null;
                    },
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    sendEmail = false;
                    Navigator.pop(context);
                  },
                  child: Text(
                    getString(context, "cancel"),
                    style: appRegularTextStyle(fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (!isValidEmail(emailController.text.trim())) {
                      setState(() {
                        emailError = getString(context, "validation_email");
                      });
                    } else {
                      sendEmail = true;
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    getString(context, "send"),
                    style: appRegularTextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          });
        }).then((value) async {
      if (sendEmail) {
        sendEmail = false;
        progressDialog(true, context);
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
        progressDialog(false, context);
        showTopSnackBar(context, message: getString(context, "reset_password_link_sent"));
      }
    });
  }
}
