import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].date;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting({required this.eventName, required this.date, required this.isAllDay});
  late String eventName;
  late DateTime date;
  late bool isAllDay;
  Meeting.fromDocumentSnapshot({required DocumentSnapshot snapshot}) {
    eventName = snapshot.get('eventName');
    date = DateTime.parse(snapshot.get('date'));
    isAllDay = snapshot.get('isAllDay');
  }
}
