import 'package:devronins_employeeee/controllers/firebase_auth_controller.dart';
import 'package:devronins_employeeee/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyAecu-UvEODyZ_juXY5rTVc9dfWS2pPdoY",
    appId: "1:379959193257:web:453c15fd0f278dd6cb83b8",
    messagingSenderId: "379959193257",
    projectId: "devroninsemployeeee",
  )).then((value) => Get.put(AuthController()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // getPages: [
      //   GetPage(name: "/welcome", page: () => const WelcomeScreen()),
      //   GetPage(name: '/employee', page: () => const EmployeeScreen()),
      //   GetPage(name: '/addemployee', page: () => const AddEmployeeScreen()),
      //   GetPage(name: '/designations', page: () => const DesignationsListing()),
      //   GetPage(name: '/userProfile', page: () => const ProfileScreen()),
      // ],
      home: const SplashScreen(),
    );
  }
}
