import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/leaveController.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class RemaingLeaveView extends StatefulWidget {
  const RemaingLeaveView({super.key});

  @override
  State<RemaingLeaveView> createState() => _RemaingLeaveState();
}

class _RemaingLeaveState extends State<RemaingLeaveView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Remaining Leave'),),
      body: GetBuilder<LeaveController>(builder: (leaveController) {
          return CustomTable(
            onRefresh: ()async{
             leaveController.getRemainingLeave();
            },
            headings: [
              "Leave Type",
              "Allocated Day",
              "Remaining Day",
              "Leave Taken"
            ],
            rowDatas: [
            ...leaveController.remainingLeaveResponse!.data!.map((e) => [
              e.leaveCategory.toString(),
              e.allowedLeaveDays.toString(),
               e.remainingDays.toString(),
               e.totalLeaveTaken.toString(),
    
            ])
              
            ],
            columnWidths: {
              0:FlexColumnWidth(1),
              //3:FlexColumnWidth(0.),
            },
           
          );
        }
      ),
    );
  }
}