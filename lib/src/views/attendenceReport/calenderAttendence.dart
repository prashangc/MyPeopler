import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/attendanceController.dart';
import 'package:my_peopler/src/core/constants/attendanceStatus.dart';
import 'package:my_peopler/src/utils/dateUtils.dart';
import 'package:my_peopler/src/utils/hexColor.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderAttendence extends StatelessWidget {
  CalenderAttendence({super.key});
  final CalendarController calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      view: CalendarView.month,
      viewHeaderHeight: 40,
      viewHeaderStyle: ViewHeaderStyle(
        backgroundColor: Colors.indigo.shade300,
        dayTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        dateTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      showDatePickerButton: true,
      initialDisplayDate: DateTime.now(),
      initialSelectedDate: DateTime.now(),
      controller: calendarController,
      onTap: (calenderDetails) {
        log(calenderDetails.date!.toString());
      },
      onViewChanged: (viewChangedDetails) {
        Get.find<AttendanceController>()
            .changeCurrentMonth(viewChangedDetails.visibleDates[16].month);
      },
      monthViewSettings: MonthViewSettings(
        appointmentDisplayCount: 2,
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        showAgenda: false,
        monthCellStyle: MonthCellStyle(
            backgroundColor: Colors.amber.shade100,
            textStyle: TextStyle(color: Colors.black),
            leadingDatesBackgroundColor: Colors.red.shade100,
            trailingDatesBackgroundColor: Colors.red.shade100,
            todayBackgroundColor: Colors.indigo.shade100),
      ),
      monthCellBuilder: (BuildContext context, MonthCellDetails details) {
        return GetX<AttendanceController>(
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(
                color:
                    getColorByDay(details.date, controller.currentMonth.value),
                border: Border.all(color: Colors.black38, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(details.date.day.toString()),
                  SizedBox(
                    height: 5,
                  ),
                  getAttendanceIcon(
                        details.date.day.isEven
                            ? AttendanceStatus.PRESENT
                            : details.date.day % 5 == 0
                                ? AttendanceStatus.ABSENT
                                : AttendanceStatus.LATE,
                        details.date,
                        controller.currentMonth.value,
                        controller.selectedDate.value,
                      ) ??
                      Container(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  getAttendanceIcon(AttendanceStatus status, DateTime date, int month,
      DateTime selectedDate) {
    if (date.month != month || date.weekday == 7 || date.weekday == 6) {
      return null;
    }
    if (date.month == selectedDate.month) {
      if (date.day > selectedDate.day) {
        return null;
      }
    }
    if(date.month > selectedDate.month || date.year > selectedDate.year){
      return null;
    }
    switch (status) {
      case AttendanceStatus.PRESENT:
        return Icon(
          Icons.check,
          color: Colors.green,
        );
      case AttendanceStatus.ABSENT:
        return Icon(
          Icons.cancel,
          color: Colors.red,
        );
      case AttendanceStatus.LATE:
        return Icon(
          Icons.running_with_errors,
          color: Colors.yellow,
        );

      default:
        return null;
    }
  }

  getColorByDay(DateTime date, int month) {
    if (date.month != month) {
      return Colors.grey.shade300;
    }

    // Today color
    if (MyDateUtils.isToday(date)) {
      return HexColor("#00C9C1");
    }

    // Saturday Color
    if (date.weekday == 7) {
      return Colors.red.shade100;
    }

    // Sunday Color
    if (date.weekday == 6) {
      return Colors.red.shade100;
    }

    return Colors.white;
  }
}
