import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/widgets/dashboard/totalEmployee/employee_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/user_controller.dart';

class TotalEmployee extends StatelessWidget {
  const TotalEmployee({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.clear)),
                  ),
                  content: EmployeeDetails(
                    index: index,
                  ),
                ));
      },
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(0.2), offset: Offset(1, 4), spreadRadius: 1, blurRadius: 5)]),
        child: Text("${UserController.instance.users[index].firstName} ${UserController.instance.users[index].lastName}"),
      ),
    );
  }
}
