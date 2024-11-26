import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/expenses/expense_model.dart';
import 'package:my_peopler/src/models/expenses/expenses_categories.dart';
import 'package:my_peopler/src/repository/expense/expenseRepository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class ExpenseController extends GetxController {
  final ExpenseRepository _expenseRepository = getIt<ExpenseRepository>();
  List<ExpensesCategories?> _expenseCategories = [];
  List<ExpensesCategories?> get expenseCategories => _expenseCategories;
  List<String> expenseKeys = [];
  List<Expense> expenses = [];
  ExpenseData? response;

  bool isLoading = false;

  getExpenseCategories() async {
    isLoading = true;
    update();
    var res = await _expenseRepository.getExpenseCategories();
    _expenseCategories = res.data.data;
    log(_expenseCategories.toString(), name: "expenseCategories");
    isLoading = false;
    update();
  }

  postExpenses(Expenses expenses) async {
    isLoading = true;
    update();
    var res = await _expenseRepository.postExpenses(expenses);
    isLoading = false;
    update();
  }

  editExpenses(Expenses expenses) async {
    isLoading = true;
    update();
    var res = await _expenseRepository.editExpenses(expenses);
    isLoading = false;
    update();
  }

  getExpenses({
    String? type,
    int? employeeId,
    NepaliDateTime? start,
    NepaliDateTime? end,
  }) async {
    isLoading = true;
    update();
    response = await _expenseRepository.getExpenses(
        type: type, employeeId: employeeId, start: start, end: end);
    expenseKeys = response?.getAllExpenseKeys() ?? [];
    expenses = response?.getAllExpenses(employeeId) ?? [];
    isLoading = false;
    update();
  }

  changeStatus(
      {required int expenseId,
      required String status,
      required int approvedAmount,
      String? note,
      bool isExpenditure = false}) async {
    var res = await _expenseRepository.changeStatus(
        expenseId: expenseId,
        status: status,
        note: note,
        approvedAmount: approvedAmount);
    if (!isExpenditure) {
      Fluttertoast.showToast(msg: res, backgroundColor: Colors.green);
    } else {
      return res;
    }
  }

  changeBulkStatus({
    List<Expense>? expenses,
    String? status,
  }) async {
    var res = await _expenseRepository.changeBulkStatus(
      expense: expenses,
      status: status,
    );
    return res;
  }
}
