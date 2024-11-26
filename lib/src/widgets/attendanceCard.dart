import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({super.key, required this.attendance});
  final Attendance attendance;
  @override
  Widget build(BuildContext context) {
    if(attendance.details.isEmpty){
      return Center(child: Text("Empty Attendances"),);
    }
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shadowColor: Pallete.primaryCol,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  MyDateUtils.getTimeOnly(attendance.details.first.attendance_date?.toLocal()),
                ),
                SizedBox(
                  height: 30,
                  child: VerticalDivider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                ),
              
                Text(
                  attendance.details.last.state == 1? MyDateUtils.getTimeOnly(attendance.details.last.attendance_date!.toLocal()):"N/A"
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attendance.shift_name??"",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Date: ${MyDateUtils.getNepaliDateOnly(attendance.attendance_date)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //       child: Icon(
          //         getAttendanceIcon(status),
          //         color: getAttendanceIconColor(status),
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }

  // getAttendanceText(AttendanceStatus status) {
  //   switch (status) {
  //     case AttendanceStatus.PRESENT:
  //       return "Present";
  //     case AttendanceStatus.ABSENT:
  //       return "Absent";
  //     case AttendanceStatus.LATE:
  //       return "Late";
  //     default:
  //       return "";
  //   }
  // }

  // getAttendanceIcon(AttendanceStatus status) {
  //   switch (status) {
  //     case AttendanceStatus.PRESENT:
  //       return Icons.verified_outlined;
  //     case AttendanceStatus.ABSENT:
  //       return Icons.cancel_outlined;
  //     case AttendanceStatus.LATE:
  //       return Icons.cancel_schedule_send;
  //     default:
  //   }
  // }

  // getAttendanceIconColor(AttendanceStatus status) {
  //   switch (status) {
  //     case AttendanceStatus.PRESENT:
  //       return Colors.green;
  //     case AttendanceStatus.ABSENT:
  //       return Colors.red;
  //     case AttendanceStatus.LATE:
  //       return Colors.yellow;
  //     default:
  //       return Colors.black;
  //   }
  // }
}
