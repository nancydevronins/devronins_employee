import 'package:devroninsemployees/controllers/login_page_controller.dart';
import 'package:devroninsemployees/pages/admin_home_page.dart';
import 'package:devroninsemployees/pages/login_page.dart';
import 'package:devroninsemployees/pages/total_emeployees_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../pages/home_page.dart';
import '../pages/landing_page.dart';
import '../widgets/dashboard/calender/calender.dart';

class RoutesClass {
  static String home = '/';
  static String adminHome = '/admin';
  static String landingPage = '/landing';
  static String loginPage = '/login';
  static String calenderPage = '/calender';
  static String totalEmployeesPage = '/total-employees';
  static String getHomeRoute() => home;
  static String getAdminHomeRoute() => adminHome;
  static String getLandingPage() => landingPage;
  static String getLoginPage() => loginPage;
  static String getCalenderPage() => calenderPage;
  static String getTotalEmployees() => totalEmployeesPage;
  static List<GetPage> routes = [
    GetPage(name: home, page: () => const HomePage()),
    GetPage(name: landingPage, page: () => const LandingPage()),
    GetPage(
      name: loginPage,
      page: () => LoginPage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: adminHome,
      page: () => AdminHomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: calenderPage,
      page: () => Calender(),
      transition: Transition.zoom,
    ),
    GetPage(
      name: totalEmployeesPage,
      page: () => TotalEmployeesPage(),
      transition: Transition.zoom,
    )
  ];
}
