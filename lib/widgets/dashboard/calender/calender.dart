import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../utils/calender_data_source.dart';
import '../../../utils/responsive_layout.dart';
import 'add_holidays_events_form.dart';

class Calender extends StatelessWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            Obx(
              () => SizedBox(
                height: Get.height,
                width: ResponsiveLayout.isLargeScreen(context) ? Get.width * 0.80 : 340,
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: MeetingDataSource(AdminHomePageController.instance.calenders),
                  // showDatePickerButton: true,
                  monthViewSettings: MonthViewSettings(
                    agendaItemHeight: Get.height * 0.1,
                    appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                    showAgenda: true,
                    showTrailingAndLeadingDates: true,
                  ),
                ),
              ),
            ),
            FloatingActionButton(
                backgroundColor: AppColors.greenColor,
                onPressed: () {
                  showDialog(context: context, builder: (ctx) => AddHolidaysEvent());
                },
                child: Icon(Icons.add))
          ],
        ),
      ),
    );

    // floatingActionButton: FloatingActionButton(
    //   backgroundColor: AppColors.greenColor,
    //   onPressed: () {
    //     showDialog(context: context, builder: (ctx) => AddHolidaysEvent());
    //   },
    //   child: Icon(Icons.add);
  }
}
