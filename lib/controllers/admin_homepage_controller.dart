import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devroninsemployees/db/firebase_db.dart';
import 'package:devroninsemployees/model/calender_model.dart';
import 'package:devroninsemployees/utils/calender_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../constants/colors.dart';

class AdminHomePageController extends GetxController {
  static AdminHomePageController instance = Get.find();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxList<Meeting> meetings = <Meeting>[].obs;
  String selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  RxString festivalValue = ''.obs;
  RxString appBarTitle = 'Welcome'.obs;
  var screenIndex = 0.obs;
  RxBool isHover1 = false.obs;
  RxBool isHover2 = false.obs;
  RxBool isHover3 = false.obs;
  RxBool isVisiblePassword = true.obs;
  RxBool isLoading = false.obs;

  List<Meeting> getDataSource(String title, DateTime date, BuildContext context) {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 10, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(title, date, endTime, AppColors.greenColor, true));
    FirebaseDb.storeCalenderData(firestore, CalenderModel(festival: title, date: date.toString()), context);

    return meetings;
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      selectedDate = args.value.toString();
    } else if (args.value is List<DateTime>) {
      _dateCount = args.value.length.toString();
    } else {
      _rangeCount = args.value.length.toString();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
