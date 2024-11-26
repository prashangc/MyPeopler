import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/models/expenses/expense_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../routes/routes.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  State<ExpensesView> createState() => _ExpensesViewState();
}

class _ExpensesViewState extends State<ExpensesView> {
  final refreshController = RefreshController();
  final expenseDate = Get.arguments[0];
  final startDate = Get.arguments[1];
  final endDate = Get.arguments[2];
  final subOrdinate = Get.arguments[3];
  final isExpenditure = Get.arguments[4];
  final index = Get.arguments[5];
  final expenditureEmployeeId = Get.arguments[6];

  @override
  void initState() {
    Get.find<ProfileController>().getProfile();
    super.initState();
  }

  int? getUserID() {
    var controller = Get.put(ProfileController());
    return controller.user?.id;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExpenseController>(builder: (controller) {
      List<Expense> expensesById = [];
      if (!isExpenditure) {
        var response = controller.response?.data ?? {};
        var dataWithId = response[expenseDate] ?? {};
        var employeeId = dataWithId.keys.first;
        expensesById = dataWithId[employeeId] ?? [];
      } else {
        var expenseKeys = controller.expenseKeys;
        var date = expenseKeys[index];
        var response = controller.response!;
        var responseData = response.data;
        var dateResponse = responseData[date]!;
        var expenses = dateResponse[expenditureEmployeeId] ?? [];
        expensesById = expenses;
      }
      if (controller.isLoading) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      } else if (expensesById.isEmpty) {
        return Scaffold(body: NoDataWidget());
      }
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Expenses',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              _tableRow(context),
              listViewBuilder(context, expensesById, refreshController,
                  subOrdinate, startDate, endDate, getUserID(), isExpenditure)
            ],
          ));
    });
  }
}

_tableRow(BuildContext context) {
  return Container(
    color: ColorManager.lightPurple2,
    height: 48,
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            child: Text(
              'category'.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall,
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width / 6,
          child: Text(
            'asking amount'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 5,
          child: Text(
            'approved amount'.toUpperCase(),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
        Text(
          'status'.toUpperCase(),
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    ),
  );
}

listViewBuilder(
    BuildContext context,
    List<Expense> expenseList,
    RefreshController refreshController,
    int? subOrdinate,
    NepaliDateTime? startDate,
    NepaliDateTime? endDate,
    int? userId,
    bool isExpenditure) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
          height: MediaQuery.of(context).size.height / 1.23,
          child: SmartRefresher(
              controller: refreshController,
              onRefresh: !isExpenditure? () async {
                subOrdinate != null
                    ? await Get.find<ExpenseController>().getExpenses(
                        employeeId: subOrdinate,
                        type: 'subordinates',
                        start: startDate,
                        end: endDate)
                    : await Get.find<ExpenseController>().getExpenses(
                        employeeId: userId,
                        type: 'own',
                        start: startDate,
                        end: endDate);
                refreshController.refreshCompleted();
              } : () async {
                refreshController.refreshCompleted();
              },
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: expenseList.length,
                  itemBuilder: (context, index) {
                    var expense = expenseList[index];
                    var status = expense.status;
                    var category = expense.category;
                    var askingAmount = expense.askingAmount;
                    var employeeId = expense.employeeId;
                    var updateId = expense.id;
                    var categoryId = expense.expenseCategoryId;
                    var approvedAmount = expense.approvedAmount ?? 0;
                    var description = expense.description;
                    var date = expense.date;
                    var employeeName = expense.employeeName;

                    return GestureDetector(
                      onTap: isExpenditure
                          ? status == 'pending' && employeeId == userId
                              ? () {
                                  Get.toNamed(Routes.EDIT_EXPENSES_VIEW,
                                      arguments: [
                                        category,
                                        askingAmount,
                                        updateId,
                                        categoryId,
                                        description,
                                        date,
                                        employeeId,
                                        startDate,
                                        endDate
                                      ]);
                                }
                              : status == 'pending' && employeeId != userId
                                  ? () {
                                      Get.toNamed(Routes.APPROVE_EXPENSES_VIEW,
                                          arguments: [
                                            askingAmount,
                                            updateId,
                                            employeeName,
                                            employeeId,
                                            startDate,
                                            endDate,
                                            category,
                                            description,
                                            date
                                          ]);
                                    }
                                  : null
                          : status == 'pending' && employeeId == userId
                              ? () {
                                  Get.toNamed(Routes.EDIT_EXPENSES_VIEW,
                                      arguments: [
                                        category,
                                        askingAmount,
                                        updateId,
                                        categoryId,
                                        description,
                                        date,
                                        employeeId,
                                        startDate,
                                        endDate
                                      ]);
                                }
                              : null,
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width,
                        color: index.isOdd
                            ? ColorManager.creamColor
                            : ColorManager.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    category ?? '',
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    askingAmount.toString(),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    approvedAmount.toString(),
                                    textAlign: TextAlign.center,
                                  )),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 7,
                                  height: 30,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: status == 'rejected'
                                            ? Colors.red
                                            : status == 'pending'
                                                ? Colors.orange
                                                : Colors.green,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Text(
                                      status.toString().toUpperCase(),
                                      textAlign: TextAlign.center,
                                      style: status != 'pending'
                                          ? TextStyle(
                                              fontSize: 8.5,
                                              color: Colors.white)
                                          : TextStyle(fontSize: 9.5),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }))),
    ],
  );
}
