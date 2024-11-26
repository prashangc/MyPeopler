import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/helpers/dateHelper.dart';
import 'package:my_peopler/src/widgets/customTable.dart';
import 'package:my_peopler/src/widgets/dateButton.dart';

class GeneratePaySlipPage extends StatelessWidget {
  const GeneratePaySlipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SizedBox(
            width: double.maxFinite,
            height: 50,
            child: DateButton(
              label: "Select Date",
              onTap: () async {
                var selectedDate = await DateHelper.pickDate(context);
                log("Selected Date: $selectedDate");
              },
            ),
          ),
        ),
        Expanded(
          child: CustomTable(
            onRefresh: ()async{
              await Future.delayed(2.seconds);
            },
            headings: ["Salary Month","Gross Salary", "Total Deduction","Net Salary","Provident Fund","Payment Status"],
            rowDatas: [
              [
                "Sept 2020","20000","1000","19000","200","Approved",
              ],
              [
                "Sept 2020","20000","1000","19000","200","Approved",
              ],
              [
                "Sept 2020","20000","1000","19000","200","Approved",
              ],
              [
                "Sept 2020","20000","1000","19000","200","Approved",
              ],
            ],
            // columnWidths: {
            //   1:FlexColumnWidth()
            // },
            columnWidths: null,
          ),
        )
      ],
    );
  }
}
