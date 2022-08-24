import 'package:flutter/material.dart';

import '../../../controllers/user_controller.dart';
import '../../../utils/responsive_layout.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ResponsiveLayout.isSmallScreen(context) ? null : 500,
      child: Column(
        children: [
          Text("${UserController.instance.users[index].firstName} ${UserController.instance.users[index].lastName}"),
          SizedBox(
            height: 12,
          ),
          Text(UserController.instance.users[index].email),
          SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}
