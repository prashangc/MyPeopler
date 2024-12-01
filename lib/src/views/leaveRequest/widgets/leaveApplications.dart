import 'package:flutter/material.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/widgets/leaveRequestCard.dart';

class LeaveApplications extends StatelessWidget {
  const LeaveApplications({super.key, required this.leaves});
  final List<Leave> leaves;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: leaves.length,
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        if (index == leaves.length - 1) {
          return Column(
            children: [
              LeaveRequestCard(
                leave: leaves[index],
              ),
              SizedBox(
                height: 25,
              )
            ],
          );
        } else {
          return LeaveRequestCard(
            leave: leaves[index],
          );
        }
      },
    );
  }
}
