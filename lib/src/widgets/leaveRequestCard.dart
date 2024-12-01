import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/constants/leaveRequestState.dart';
import 'package:my_peopler/src/core/extensions/string/string_ext.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({
    super.key,
    this.hPad = 0,
    required this.leave,
  });

  final double hPad;

  final Leave leave;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 234, 233, 233),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Pallete.primaryCol,
              ),
              SizedBox(width: 12.0),
              Text(
                "Reason",
                style: TextStyle(
                  color: Pallete.primaryCol,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              )
            ],
          ),
          SizedBox(height: 12.0),
          Text(
            leave.reason?.capitalizeFirst() ?? "",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 5.0),
          Divider(),
          SizedBox(height: 5.0),
          if (leave.start_date?.hour != 0) ...{
            iconCard(
              iconData: Icons.timer_outlined,
              text: '${leave.end_date!.hour}:${leave.end_date!.minute}',
            ),
            SizedBox(height: 12.0),
          },
          iconCard(
            iconData: Icons.date_range,
            text:
                "${MyDateUtils.getDateOnly(leave.start_date)}  -  ${MyDateUtils.getDateOnly(leave.end_date)}",
          ),
        ],
      ),
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Text(
      //       leave.reason?.capitalizeFirst() ?? "",
      //       style: Theme.of(context).textTheme.titleLarge,
      //       textAlign: TextAlign.justify,
      //       maxLines: 2,
      //       overflow: TextOverflow.ellipsis,
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text("From:  "),
      //         Text(
      //          ,
      //           style: Theme.of(context).textTheme.bodySmall,
      //         ),
      //         SizedBox(
      //           width: 24,
      //         ),
      //         leave.start_date?.hour != 0
      //             ? Text(
      //                 '${leave.start_date!.hour}:${leave.start_date!.minute}',
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               )
      //             : Text('N/A')
      //       ],
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text("To:       "),
      //         Text(
      //
      //           style: Theme.of(context).textTheme.bodySmall,
      //         ),
      //         SizedBox(
      //           width: 25,
      //         ),
      //         leave.end_date?.hour != 0
      //             ? Text(
      //                 ,
      //                 style: Theme.of(context).textTheme.bodySmall,
      //               )
      //             : Text('')
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  Widget iconCard({
    required IconData iconData,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          iconData,
          size: 14.0,
          color: Pallete.primaryCol,
        ),
        SizedBox(width: 12.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }

  LeaveRequestState getLeaveState(int? status) {
    if (status == null) {
      return LeaveRequestState.PENDING;
    }
    if (status == 0) {
      return LeaveRequestState.PENDING;
    } else if (status == 1) {
      return LeaveRequestState.PENDING;
    } else {
      return LeaveRequestState.APPROVED;
    }
  }

  getLeaveRequestStateIcon(LeaveRequestState state) {
    switch (state) {
      case LeaveRequestState.PENDING:
        return Icons.pending;
      case LeaveRequestState.APPROVED:
        return Icons.verified;
      // case LeaveRequestState.REJECTED:
      //   return Icons.cancel;
      default:
        return Icons.pending;
    }
  }

  getLeaveRequestStateColor(LeaveRequestState state) {
    switch (state) {
      case LeaveRequestState.PENDING:
        return Colors.yellow;
      case LeaveRequestState.APPROVED:
        return Colors.green;
      // case LeaveRequestState.REJECTED:
      //   return Colors.red;
      default:
        return Colors.yellow;
    }
  }
}
