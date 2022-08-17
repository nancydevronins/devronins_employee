import 'package:devroninsemployees/constants/colors.dart';
import 'package:devroninsemployees/controllers/admin_homepage_controller.dart';
import 'package:devroninsemployees/widgets/dashboard/add_holidays_events_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../utils/calender_data_source.dart';
import '../utils/responsive_layout.dart';

class CalenderPage extends StatelessWidget {
  const CalenderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            SizedBox(
                height: Get.height,
                width: ResponsiveLayout.isSmallScreen(context) && ResponsiveLayout.isMediumScreen(context)
                    ? Get.size.width * 0.1
                    : Get.size.width * 0.85,
                child: Obx(
                  () => SfCalendar(
                    view: CalendarView.month,
                    dataSource: MeetingDataSource(AdminHomePageController.instance.meetings.value),
                    showDatePickerButton: true,
                    monthViewSettings: MonthViewSettings(
                      agendaItemHeight: Get.height * 0.1,
                      appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                      showAgenda: true,
                      showTrailingAndLeadingDates: true,
                    ),
                  ),
                )),
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
