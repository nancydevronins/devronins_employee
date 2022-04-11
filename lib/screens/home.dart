import 'package:devronins_employeeee/constants/colors.dart';
import 'package:devronins_employeeee/constants/helper/app_helper.dart';
import 'package:devronins_employeeee/responsive_layout.dart';
import 'package:devronins_employeeee/screens/designations_listing_screen.dart';
import 'package:devronins_employeeee/screens/employee_screen.dart';
import 'package:devronins_employeeee/screens/welcome_screen.dart';
import 'package:devronins_employeeee/widgets/resourses.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List<SideBarMenuItems> children = [];
  DateTime? currentBackPressTime;
  int selectedPageIndex = 0;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (selectedPageIndex != 0) {
      setState(() {
        selectedPageIndex = 0;
      });
      return Future.value(false);
    } else if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
  }

  void prepareBottomNavigationPages() {
    children.clear();
    children = [
      SideBarMenuItems(route: const WelcomeScreen(), title: getString(context, 'dashboard'), icon: Icons.add_to_home_screen),
      SideBarMenuItems(title: getString(context, 'employees'), icon: Icons.person, route: const EmployeeScreen()),
      SideBarMenuItems(title: getString(context, 'designations'), icon: Icons.details, route: const DesignationsListing()),
      SideBarMenuItems(title: getString(context, 'departments'), icon: Icons.details, route: const DesignationsListing()),
    ];
  }

  @override
  void initState() {
    super.initState();
    prepareBottomNavigationPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: (ResponsiveLayout.isTinyLimit(context) || ResponsiveLayout.isTinyHeightLimit(context)
            ? Container()
            : AppBar(
          title: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text(
              getTitleText(),
              style: appRegularTextStyle(fontSize: 22, color: Colors.white),
            ),
          ),
        )),
      ),
      backgroundColor: AppColor.scaffoldBackGroundColor,
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('DevRonins', style: appSemiBoldTextStyle(fontSize: 24, color: Colors.white),),
                  Image.asset('assets/images/ic_company_logo.png', width: 220),
                ],
              ),
            ),
            space(height: 20),
            for (int index = 0; index < children.length; index++) ...{
              InkWell(
                onTap: () {
                  setState(() {
                    selectedPageIndex = index;
                  });
                  Navigator.pop(context);
                },
                child: Container(
                  child: Text(
                    children[index].title,
                    style: appSemiBoldTextStyle(fontSize: 20, color: AppColor.appBlue),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                ),
              ),
            },
          ],
        ),
      ),
      body: IndexedStack(
        index: selectedPageIndex,
        children: children.map((e) => e.route).toList(growable: true),
      ),
    );
  }

  String getTitleText() {
    if(selectedPageIndex == 1) {
      return getString(context, "employees");
    } else if(selectedPageIndex == 2) {
      return getString(context, "designations");
    } else {
      return "DevRonins";
    }
  }

}
