import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/models/payroll/payrollResponse.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SalaryStructurePage extends StatelessWidget {
  SalaryStructurePage({Key? key}) : super(key: key);
  final RefreshController refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      onRefresh: () async {
        await Get.find<PayrollController>().refreshPayroll();
        refreshController.refreshCompleted();
      },
      child: GetBuilder<PayrollController>(builder: (payrollController) {
        if (payrollController.isRefreshing.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
         Payroll? payRoll = payrollController.payRoll;
        if (payRoll == null) {
          return Center(
            child: Text("Error while getting payroll"),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Salary",
                  style: TextStyle(color: Colors.black87, fontSize: 22),
                ),
                Text(
                  "Rs.${payRoll.basic_salary ?? ""}",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Allowances",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "House Rent",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.house_rent_allowance ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Medical",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.medical_allowance ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Special",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.special_allowance ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Deductions",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tax",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.tax_deduction ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Provident Fund",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.provident_fund_deduction ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Others",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Allowances",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.other_allowance ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deduction",
                          style: TextStyle(color: Colors.black54, fontSize: 22),
                        ),
                        Text(
                          "Rs.${payRoll.other_deduction ?? ""}",
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20,)
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
