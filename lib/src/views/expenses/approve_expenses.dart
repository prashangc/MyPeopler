import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';

class ApproveExpenses extends StatefulWidget {
  const ApproveExpenses({super.key});

  @override
  State<ApproveExpenses> createState() => _ApproveExpensesState();
}

class _ApproveExpensesState extends State<ApproveExpenses> {
  TextEditingController? noteController = TextEditingController();
  TextEditingController askingAmountController = TextEditingController();
  TextEditingController approvedAmountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
 
  final askingAmount = Get.arguments[0];
  final expenseID = Get.arguments[1];
  final employeeName = Get.arguments[2];
  final employeeId = Get.arguments[3];
  final startDate = Get.arguments[4];
  final endDate = Get.arguments[5];
  final category = Get.arguments[6];
  final description = Get.arguments[7];
  final date = Get.arguments[8];
  


  @override
  void initState() {
    askingAmountController.text = askingAmount;
    descriptionController.text = description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selectedDate = date.toString().split(' ')[0];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Approve Expenses'),
      ),
      body: GetBuilder<ExpenseController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text(employeeName,style: TextStyle(fontSize: 18),)),
                  SizedBox(height: 20,),
                  Text(' Category: $category', style: TextStyle(fontSize: 14),),
                  SizedBox(height: 5,),
                  Text(' Date: $selectedDate', style: TextStyle(fontSize: 14),),
                  SizedBox(height: 10,),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    readOnly: true,
                  ),
                   SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Note'.toUpperCase(),
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: noteController,
                    maxLines: 5,
                    decoration: InputDecoration(hintText: 'Write some note here..'),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: askingAmountController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Asking Amount'),
                    readOnly: true,
                  ),
                   SizedBox(
                    height: 30,
                  ),
                   TextFormField(
                    controller: approvedAmountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Approve Amount'),
                    validator: (text) {
                    if (text == null || text.isEmpty) {
                    return 'Fill Approve amount';
                  }
                  return null;
                    },
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()) {
                            controller.changeStatus(
                            expenseId: expenseID,
                            status: 'approved',
                            approvedAmount: int.parse(approvedAmountController.text),
                            note: noteController?.text ?? '');
                             MessageHelper.showSuccessAlert(
                                        context: context,
                                        title: 'Success',
                                        desc: 'Expense Approved',
                                        btnOkOnPress: () {
                                          controller.getExpenses(employeeId: employeeId, type: 'subordinates' ,start: startDate, end: endDate);
                                          Get.back();
                                        });
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.green),
                          fixedSize:
                              WidgetStatePropertyAll(Size(double.maxFinite, 60))),
                      child: Text(
                        'Approve',
                        style: TextStyle(fontSize: 18),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                           controller.changeStatus(
                            expenseId: expenseID,
                            status: 'rejected',
                            approvedAmount: 0,
                            note: noteController?.text ?? '');
                         MessageHelper.showSuccessAlert(
                                        context: context,
                                        title: 'Success',
                                        desc: 'Expense Rejected',
                                        btnOkOnPress: () {
                                          controller.getExpenses(employeeId: employeeId, type: 'subordinates', start: startDate, end: endDate);
                                          Get.back();
                                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          fixedSize:
                              WidgetStatePropertyAll(Size(double.maxFinite, 60))),
                      child: Text(
                        'Reject',
                        style: TextStyle(fontSize: 18),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
