import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../controllers/user_controller.dart';
import '../../../utils/nemorphism_shadow.dart';
import '../../../utils/responsive_layout.dart';

class EmployeeDetails extends StatelessWidget {
  const EmployeeDetails({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ResponsiveLayout.isSmallScreen(context) ? null : 500,
      child: Column(
        children: [
          profieImg,
          const SizedBox(
            height: 12,
          ),
          Text("${UserController.instance.users[index].firstName} ${UserController.instance.users[index].lastName}"),
          const SizedBox(
            height: 12,
          ),
          Text(UserController.instance.users[index].email),
          const SizedBox(
            height: 12,
          ),
          Text(UserController.instance.users[index].phone),
          const SizedBox(
            height: 12,
          ),
          Text(UserController.instance.users[index].designation),
        ],
      ),
    );
  }

  Container get profieImg {
    return Container(
      height: Get.height * 0.35,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: NeomorphismShape.boxShape,
        color: AppColors.white10,
      ),
      child: UserController.instance.users[index].profileUrl.isEmpty
          ? Image.asset(
              Images.placeholder,
              height: 20,
            )
          : Image.network(UserController.instance.users[index].profileUrl),
    );
  }
}
