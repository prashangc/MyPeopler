import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/payrollController.dart';
import 'package:my_peopler/src/widgets/customTable.dart';

class SalaryListPage extends StatelessWidget {
  const SalaryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollController>(builder: (payrollController) {
      return Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //   child: SizedBox(
          //     width: double.maxFinite,
          //     height: 50,
          //     child: DateButton(
          //       label: "Select Date",
          //       onTap: () async {
          //         var selectedDate = await DateHelper.pickDate(context);
          //         log("Selected Date: $selectedDate");
          //       },
          //     ),
          //   ),
          // ),
          Expanded(
            child: CustomTable(
              onRefresh: () async {
               payrollController.getPaySlip();
              },
              headings: [
                "Date",
                'Basic Salary',
                'Allowance',
                'Deduction',
                'Tax',
                'Net Salary'
              ],
              rowDatas: [
                ...payrollController.payslipResponse.map((e) => [
                      '${e.fromDate!.year}-${e.fromDate!.month}-${e.fromDate!.month}  -  ${e.toDate!.year}-${e.toDate!.month}-${e.toDate!.month}',
                      '${e.basicSalary}',
                      '${e.allowance}',
                      '${e.deduction}',
                      '${e.tax}',
                      '${e.netSalary}',
                    ])
              ],
              columnWidths: {
                3: FlexColumnWidth(0.9),
                4: FlexColumnWidth(0.5),
              },
            ),
          ),
           SizedBox(height: 75,)
        ],
       
      );
    });
  }

  // _buildSalaryListCard(){
  //   return SplashWidget(
  //           onTap: null,
  //           splashColor: Pallete.primaryCol,
  //           shadowColor: Colors.black,
  //           radius: 8,
  //           bgCol: Colors.white,
  //           contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
  //           margin: EdgeInsets.symmetric(horizontal: 0,vertical: 10),
  //           elevation: 5,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text("Date: 2022-02-03",),
  //               Text("Rs. 10,000",),
  //             ],
  //           ),
  //         );
  // }
}
