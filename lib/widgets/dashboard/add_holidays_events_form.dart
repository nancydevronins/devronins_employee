import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/utils/wave_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../utils/responsive_layout.dart';

class AddHolidaysEvent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Holidays'),
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.clear))
          ],
        ),
      ),
      content: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SizedBox(
          width: ResponsiveLayout.isSmallScreen(context) ? null : 500,
          child: SingleChildScrollView(
              child: Obx(
            () => Column(
              children: [
                TextField(
                  onChanged: (value) {
                    AdminHomePageController.instance.festivalValue.value = value;
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greenColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintText: Strings.title,
                      labelText: Strings.festivalTitle),
                ),
                SizedBox(
                  height: 12,
                ),
                SfDateRangePicker(
                  onSelectionChanged: AdminHomePageController.instance.onSelectionChanged,
                  onSubmit: (selected) {},
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: AdminHomePageController.instance.festivalValue.value.isEmpty
                        ? null
                        : () {
                            AdminHomePageController.instance.storeCalenderData(
                                AdminHomePageController.instance.festivalValue.value, AdminHomePageController.instance.selectedDate, context);
                          },
                    child: Container(
                        width: ResponsiveLayout.isSmallScreen(context) ? null : Get.width / 8,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              AdminHomePageController.instance.festivalValue.value.isEmpty ? Colors.grey : AppColors.greenColor,
                              AdminHomePageController.instance.festivalValue.value.isEmpty ? Colors.grey : AppColors.blueColor,
                            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [BoxShadow(color: AppColors.blueColor.withOpacity(.3), offset: Offset(0, 8), blurRadius: 8)]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          child: Center(
                            child: Text(Strings.add.toUpperCase(),
                                style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 1, fontWeight: FontWeight.bold)),
                          ),
                        )),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
