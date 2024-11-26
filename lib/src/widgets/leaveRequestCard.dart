import 'package:flutter/material.dart';
import 'package:my_peopler/src/core/constants/leaveRequestState.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/splashWidget.dart';

class LeaveRequestCard extends StatelessWidget {
  const LeaveRequestCard({
    Key? key,
    this.hPad = 0,
    required this.leave,
  }) : super(key: key);

  final double hPad;

  final Leave leave;
  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      onTap: null,
      shadowColor: Colors.black,
      splashColor: Pallete.primaryCol,
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: hPad),
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      radius: 8,
      bgCol: Colors.white,
      elevation: 3,
      border: Border.all(color: Pallete.primaryCol.withOpacity(0.7)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leave.reason ?? "",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.justify,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text("From:  "),
                      Text(
                        MyDateUtils.getDateOnly(leave.start_date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(width: 24,),
                      leave.start_date?.hour != 0 ? Text(
                        leave.start_date!.hour.toString()+':'+leave.start_date!.minute.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ):Text('')
                    ],
                  ),
                  Row(
                    children: [
                      Text("To:       "),
                      Text(
                        MyDateUtils.getDateOnly(leave.end_date),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                       SizedBox(width: 25,),
                      leave.end_date?.hour != 0? Text(
                        leave.end_date!.hour.toString()+':'+leave.end_date!.minute.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ):Text('')
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Icon(
          //   getLeaveRequestStateIcon(getLeaveState(leave.publication_status)),
          //   color: getLeaveRequestStateColor(getLeaveState(leave.publication_status)),
          // ),
          SizedBox(
            width: 15,
          )
        ],
      ),
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
