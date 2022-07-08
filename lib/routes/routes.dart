import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/pages/admin_home_page.dart';
import 'package:devroninsemployees/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home_page.dart';
import '../pages/landing_page.dart';

class RoutesClass {
  static String home = '/';
  static String adminHome = '/admin';
  static String landingPage = '/landing';
  static String loginPage = '/login';
  static String getHomeRoute() => home;
  static String getAdminHomeRoute() => adminHome;
  static String getLandingPage() => landingPage;
  static String getLoginPage() => loginPage;
  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: landingPage, page: () => const LandingPage()),
    GetPage(
        name: loginPage,
        page: () => LoginPage(),
        transition: Transition.fadeIn,
        binding: BindingsBuilder(() => Get.lazyPut(() => LoginPageController()))),
    GetPage(
      name: adminHome,
      page: () => AdminHomePage(),
      transition: Transition.fadeIn,
    )
  ];
}
