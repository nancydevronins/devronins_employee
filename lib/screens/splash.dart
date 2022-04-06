import 'package:after_layout/after_layout.dart';
import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/screens/login_screen.dart';
import 'package:devronins_employeeee/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }

}

class SplashState extends State<SplashScreen> with AfterLayoutMixin<SplashScreen> {

  @override
  void afterFirstLayout(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    Future.delayed(const Duration(seconds: 1), () {
      if(user == null) {
        openPage(context, const LoginScreen());
      } else {
        openPage(context, const WelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/ic_company_logo.png', width: 520),
      ),
    );
  }

}