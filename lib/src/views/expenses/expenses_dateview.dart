import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/attendanceController.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/expenses/expense_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/views/expenses/expense_bottomsheet.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ExpensesDate extends StatefulWidget {
  const ExpensesDate({super.key});

  @override
  State<ExpensesDate> createState() => _ExpensesDateState();
}

class _ExpensesDateState extends State<ExpensesDate> {
  final refreshController = RefreshController();
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  NepaliDateTime? startDate;
  NepaliDateTime? endDate;
  NepaliDateTime? starAttendanceDate;
  NepaliDateTime? endAttendanceDate;
  bool showStatus = false;
  String status = '';

  @override
  void initState() {
    employeeFilterName = TextEditingController();
    Get.find<SfaProductListController>().getSubOrdinates();
    Get.find<ProfileController>().getProfile();
    Get.find<ExpenseController>()
        .getExpenses(employeeId: getUserId(), type: 'own');
    Get.find<ExpenseController>().getExpenseCategories();
    Get.find<AttendanceController>().getExpenseAttendance(null, null, null);
    super.initState();
  }

  int? getUserId() {
    var controller = Get.put(ProfileController());
    return controller.user?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Expenses Date'),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                onPressed: () async {
                  var controller = Get.find<ExpenseController>();
                  var attendanceController = Get.find<AttendanceController>();
                  _modalBottomSheet(controller, attendanceController);
                },
                icon: Icon(Icons.filter_alt),
                iconSize: 30,
              ),
            )
          ],
        ),
        floatingActionButton: subOrdinateId == null
            ? FloatingActionButton(
                tooltip: 'Add Expenses',
                backgroundColor: ColorManager.primaryCol,
                onPressed: () {
                  Get.toNamed(Routes.ADD_EXPENSES_VIEW);
                },
                child: Icon(Icons.add),
              )
            : null,
        body: GetBuilder<ExpenseController>(builder: (controller) {
          var expensekeys = controller.expenseKeys;

            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.expenses.isEmpty) {
              return SmartRefresher(
                  controller: refreshController,
                  onRefresh: () async {
                    subOrdinateId = null;
                    startDate = null;
                    endDate = null;
                    await Get.find<ExpenseController>()
                        .getExpenses(employeeId: getUserId(), type: 'own');
                    await Get.find<ExpenseController>().getExpenseCategories();
                    await Get.find<AttendanceController>()
                        .getExpenseAttendance(null, null, null);
                    refreshController.refreshCompleted();
                  },
                  child: NoDataWidget());
            }
            return SmartRefresher(
                controller: refreshController,
                onRefresh: () async {
                  setState(() {
                    subOrdinateId = null;
                    startDate = null;
                    endDate = null;
                  });
                  await Get.find<ExpenseController>()
                      .getExpenses(employeeId: getUserId(), type: 'own');
                  await Get.find<ExpenseController>().getExpenseCategories();
                  refreshController.refreshCompleted();
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      var expenseDate = expensekeys[index];
                      var response = controller.response?.data ?? {};
                      var dataWithId = response[expenseDate] ?? {};
                      var employeeId = dataWithId.keys.first;
                      
                      var expensesById = dataWithId[employeeId] ?? [];
                      
                      if(expensesById.any((element) => element.status == 'pending')) {
                          status = 'pending';
                        }
                      else if(expensesById.every((e) => e.status == 'approved')) {
                        status = 'approved';
                      } else if(expensesById.every((e) => e.status == 'rejected')){
                        status = 'rejected';
                      } else {
                        status = 'completed';
                      }
                      var totalAskingExpense = expensesById.fold(0 , ((previousValue, element) => previousValue + int.parse(element.askingAmount)));
                      var totalApprovedExpense = expensesById.fold(0 , ((previousValue, element) {
                      int approvedAmount = element.approvedAmount ?? 0;
                      return  previousValue + approvedAmount;
                      }));
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EXPENSES_VIEW, arguments: [
                            expenseDate,
                            startDate,
                            endDate,
                            subOrdinateId,
                            false,
                            null,
                            null
                          ]);
                        },
                        child: Container(
                          height: 150,
                          padding: EdgeInsets.only(top: 0, left: 8, right: 8),
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 1),
                                blurRadius: 5,
                                color: Colors.black.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month_sharp,
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    expenseDate,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorManager.primaryCol),
                                  ),
                                  Spacer(),
                                  Container(
                                      height: 20,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: status == 'pending'
                                              ? Colors.orange
                                              : status == 'approved'
                                                  ? Colors.green
                                                  : status == 'rejected'
                                                      ? Colors.red
                                                      : const Color.fromARGB(
                                                  255, 200, 156, 24)),
                                      child: Center(
                                          child: Text(
                                        status,
                                        style: TextStyle(color: Colors.white),
                                      )))
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Total Asking Amount:  Rs.${totalAskingExpense.toString()}'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Total Approved Amount:  Rs.${totalApprovedExpense.toString()}'),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 0,
                        ),
                    itemCount: expensekeys.length));
        }));
  }

  _modalBottomSheet(ExpenseController controller,
      AttendanceController attendanceController) async {
    var dates = await Get.bottomSheet(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        ExpenseBottomSheet(
            userId: getUserId()!,
            controller: controller,
            attendanceController: attendanceController,
            employeeFilterName: employeeFilterName));
    if (dates != null) {
      startDate = dates[0];
      endDate = dates[1];
      setState(() {
        subOrdinateId = dates[2];
      });
    }
  }

}
