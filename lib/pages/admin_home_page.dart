import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/controllers/auth_controller.dart';
import 'package:devroninsemployees/pages/calender_page.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: AppBar(
        title: Obx(() => Text(
              AdminHomePageController.instance.appBarTitle.value,
              style: TextStyle(color: Colors.white),
            )),
        actions: [
          IconButton(
              onPressed: () {
                AuthController.instance.logout();
              },
              icon: Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                AppColors.greenColor,
                AppColors.blueColor,
              ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
        ),
      ),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            Obx(() => Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [
                        AppColors.greenColor,
                        AppColors.blueColor,
                      ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                      boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
                  child: NavigationRail(
                    minWidth: 60,
                    indicatorColor: Colors.black54,
                    selectedLabelTextStyle: TextStyle(color: Colors.white),
                    labelType: NavigationRailLabelType.selected,
                    backgroundColor: Colors.transparent,
                    selectedIndex: AdminHomePageController.instance.screenIndex.value,
                    destinations: navRailDestinations,
                    onDestinationSelected: (index) {
                      AdminHomePageController.instance.screenIndex.value = index;
                    },
                  ),
                )),
            Obx(() => createScreenFor(AdminHomePageController.instance.screenIndex.value))
          ],
        ),
      ),
    );
  }

  Widget createScreenFor(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return DashBoard();
      case 1:
        return const CalenderPage();
      case 2:
        return const Text('dfg');
      case 3:
        return const Text('dfgsa');
      default:
        return Text('fdgdfgdf');
    }
  }
}

List<NavigationRailDestination> navRailDestinations = const [
  NavigationRailDestination(
    icon: Icon(Icons.widgets_outlined),
    label: Text('Dashboard'),
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.text_snippet_outlined),
    label: Text('Calender'),
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.feedback),
    label: Text('Enquery'),
    selectedIcon: Icon(Icons.feedback_outlined),
  ),
  NavigationRailDestination(
    icon: Icon(Icons.settings),
    label: Text('Settings'),
    selectedIcon: Icon(Icons.settings_outlined),
  )
];
