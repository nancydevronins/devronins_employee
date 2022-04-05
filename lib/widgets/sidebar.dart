import 'package:devronins_employeeee/responsive_layout.dart';
import 'package:devronins_employeeee/widgets/resourses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late int _currentindex = 0;

  final List<SideBarMenuItems> _menuNames = [
    SideBarMenuItems(
        route: '/welcome', title: "DashBoard", icon: Icons.add_to_home_screen),
    SideBarMenuItems(title: "Employee", icon: Icons.person, route: '/employee'),
    SideBarMenuItems(
        title: "Designations", icon: Icons.details, route: '/designations'),
    SideBarMenuItems(
        title: "Training",
        icon: Icons.track_changes_outlined,
        route: '.employee'),
  ];
  @override
  Widget build(BuildContext context) {
    final isCollapsed = false;
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);
    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
        backgroundColor: Color(0xffff8dbb55),
        // child: SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       ListTile(
        //         title: const Text(
        //           "Admin Menu",
        //           style: TextStyle(color: Colors.white),
        //         ),
        //         trailing: ResponsiveLayout.isComputer(context)
        //             ? null
        //             : IconButton(
        //                 onPressed: () {},
        //                 icon: const Icon(
        //                   Icons.close,
        //                   color: Colors.white,
        //                 )),
        //       ),
        //       ...List.generate(
        //         _menuNames.length,
        //         (index) => Column(
        //           children: [
        //             Container(
        //               decoration: BoxDecoration(
        //                   borderRadius: BorderRadius.circular(15)),
        //               child: ListTile(
        //                 title: Text(
        //                   _menuNames[index].title,
        //                   style: const TextStyle(color: Colors.white),
        //                 ),
        //                 leading: Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Icon(
        //                     _menuNames[index].icon,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //                 onTap: () {
        //                   setState(() {
        //                     Get.toNamed(_menuNames[index].route);
        //                     _currentindex = index;
        //                   });
        //                 },
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // )),

        child: Container(
          child: Column(
            children: [
              Container(
                  color: Colors.white12,
                  padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                  child: buildHeader(isCollapsed))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? const FlutterLogo(size: 48)
      : Row(
          children: const [
            SizedBox(width: 24),
            FlutterLogo(
              size: 48,
            ),
            SizedBox(width: 16),
            Text(
              "Flutter",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        );
}
