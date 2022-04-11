import 'package:after_layout/after_layout.dart';
import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/screens/home.dart';
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
  void afterFirstLayout(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    print("App user: $user");
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
      if(user == null) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const LoginScreen()), ModalRoute.withName('/'));
      } else {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => const HomePage()), ModalRoute.withName('/'));
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