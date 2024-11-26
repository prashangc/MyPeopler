import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/attendanceController.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class ExpenseBottomSheet extends StatefulWidget {
  final ExpenseController controller;
  final AttendanceController attendanceController;
  final TextEditingController? employeeFilterName;
  final int userId;
 const ExpenseBottomSheet(
      {super.key, required this.controller, this.employeeFilterName, required this.attendanceController, required this.userId});

  @override
  State<ExpenseBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<ExpenseBottomSheet> {
  NepaliDateTime? startDate;
  NepaliDateTime? endDate;
  int? subOrdinateId;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SfaProductListController>(
      builder: (pController) {
        return DraggableScrollableSheet(
            snap: true,
            initialChildSize: 1,
            builder: (context, scrollController) {
              return Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: 8,
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DateRangeButton(
                        isNepaliDate: true,
                        nepaliDateFrom: startDate,
                        nepaliDateTo: endDate,
                        width: 1,
                        label: "From Date     -      To Date",
                        onTap: () async {
                          NepaliDateTimeRange? date =
                              await showMaterialDateRangePicker(
                            context: context,
                            firstDate: NepaliDateTime(1970),
                            lastDate: NepaliDateTime(2250),
                          );
                          if (date != null) {
                            setState(() {
                              startDate = date.start;
                            });
                            setState(() {
                              endDate = date.end;
                            });
                          }
                        },
                      ),
                      TextField(
                        textAlign: TextAlign.center,
                        readOnly: true,
                        controller: widget.employeeFilterName,
                        decoration:
                            InputDecoration(labelText: 'Choose Subordinate'),
                        onTap: () {
                          showSubOrdinate(
                              context, pController, widget.employeeFilterName);
                        },
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            widget.controller.getExpenses(
                                type: subOrdinateId != null? 'subordinates' : 'own',
                                employeeId: subOrdinateId ?? widget.userId,
                                start: startDate,
                                end: endDate);
                            widget.attendanceController.refreshAttendance(
                            subOrdinateId, start:startDate, endDate: endDate, isExpense: true);   
                            widget.employeeFilterName?.clear();
                            Get.back(result: [startDate,endDate, subOrdinateId]);
                            subOrdinateId = null;
                          },
                          style: ButtonStyle(
                              minimumSize: WidgetStateProperty.all(
                                  Size(double.maxFinite, 50))),
                          child: Text(
                            'Filter',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      )
                    ]),
              );
            });
      },
    );
  }

  Future<void> showSubOrdinate(
      BuildContext context,
      SfaProductListController controller,
      TextEditingController? employeeFilterName) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3.7,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
              itemCount: controller.subOrdinates?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(controller.subOrdinates![index].name.toString()),
                  onTap: () {
                    employeeFilterName?.text =
                        controller.subOrdinates![index].name.toString();
                    subOrdinateId = controller.subOrdinates![index].id;
                    Get.back();
                  },
                );
              },
            ),
          );
        });
  }
}
