import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/utils/responsive_layout.dart';
import 'package:devroninsemployees/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: DashBoardDrawer(),
      appBar: ResponsiveLayout.isSmallScreen(context) ? AppBar() : null,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: ResponsiveLayout.isLargeScreen(context) || ResponsiveLayout.isMediumScreen(context)
                  ? Obx(() => NavigationRail(
                        minWidth: 60,
                        selectedIndex: AdminHomePageController.instance.screenIndex.value,
                        destinations: navRailDestinations,
                        onDestinationSelected: (index) {
                          AdminHomePageController.instance.screenIndex.value = index;
                        },
                      ))
                  : Container(),
            ),
            Obx(() => createScreenFor(AdminHomePageController.instance.screenIndex.value))
          ],
        ),
      ),
    );
  }

  Widget createScreenFor(int screenIndex) {
    switch (screenIndex) {
      case 0:
        return Text('Das');
      case 1:
        return const Text('sfdet');
      case 2:
        return const Text('dfg');
      case 3:
        return const Text('dfgsa');
      default:
        return Text('fdgdfgdf');
    }
  }
}

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.widgets_outlined),
    label: 'Dashboard',
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.text_snippet_outlined),
    label: 'Typography',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: "",
    icon: Icon(Icons.settings),
    label: 'Elevation',
    selectedIcon: Icon(Icons.settings_outlined),
  )
];
final List<NavigationRailDestination> navRailDestinations = appBarDestinations
    .map(
      (destination) => NavigationRailDestination(
        icon: Tooltip(
          message: destination.label,
          child: destination.icon,
        ),
        selectedIcon: Tooltip(
          message: destination.label,
          child: destination.selectedIcon,
        ),
        label: Text(destination.label),
      ),
    )
    .toList();
