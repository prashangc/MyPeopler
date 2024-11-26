
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaPaymentScheduleController.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

class PaymentPlans extends StatefulWidget {
  const PaymentPlans({super.key});

  @override
  State<PaymentPlans> createState() => _PaymentPlansState();
}

class _PaymentPlansState extends State<PaymentPlans> {
  final title = Get.arguments['customerTitle'];
  final paymentScheduleApi = Get.arguments['paymentScheduleApi'];
  final scheduleIndex = Get.arguments['index'];
  final itemIndex = Get.arguments['itemIndex'];
  final dateApi = Get.arguments['dateApi'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
             _modalBottomSheet(paymentScheduleApi.id);
          }, icon: Icon(Icons.add,size: 30,))
        ],
      ),
      body: GetBuilder<SfaPaymentScheduleController>(builder: (controller) {
         if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } 
        return ListView.separated(
          shrinkWrap: true,
          itemCount: controller.sfaPaymentSchedule![scheduleIndex].items[itemIndex].plans.length,
          separatorBuilder: (context, index) => SizedBox(height: 5,),
          itemBuilder: (context, index) {
            var plans = controller.sfaPaymentSchedule?[scheduleIndex].items[itemIndex].plans[index];
            return Card(
              child: Container(
               height: 120,
              width: double.maxFinite,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.grey),
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 50,
                    // offset: Offset(0,3),
                    blurStyle: BlurStyle.outer
                  )
                ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                                  Text(
                                                    'Achievement: ${plans?.achievement ?? 0}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    'Planning Amount: Rs.${plans?.planningAmount ?? 0}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    'Planning Date: ${plans?.planningDate}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .displaySmall,
                                                  )
                ],
              ),
                        ),
            );
          },
        );}),
    );
  }
  
    Future<picker.NepaliDateTime?> selectDate(BuildContext context, picker.NepaliDateTime? initialDate,
      TextEditingController dateController) async {
    final picker.NepaliDateTime? picked = await picker.showAdaptiveDatePicker(
        context: context,
        initialDate: initialDate!,
        language: picker.Language.nepali,
        firstDate: picker.NepaliDateTime(2000, 1),
        lastDate: picker.NepaliDateTime(2100));
    if (picked != null && picked != initialDate) {
      initialDate = picked;
      var pickedDate = picked.toString().split(" ")[0];
      dateController.value = TextEditingValue(text: pickedDate);
    }
    return picked;
  }

  picker.NepaliDateTime? pickedDate;

  _modalBottomSheet(int itemId) {
    TextEditingController dateController = TextEditingController();
    picker.NepaliDateTime? date = picker.NepaliDateTime.now();
    TextEditingController planningAmountController = TextEditingController();
    var fromDate = dateApi.fromDate;
    var toDate = dateApi.toDate;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (builder) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                       bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close))),
                          SizedBox(height: 10,),
                          Text("Planning Date", style: TextStyle(fontSize: 16),),
                          SizedBox(height: 10,),
                          GestureDetector(
                            onTap: () async {
                              pickedDate = await selectDate(
                                  context, date, dateController);
                            },
                            child: AbsorbPointer(
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: dateController,
                                decoration: InputDecoration(fillColor: Colors.indigo.shade50,filled: true, hintText: 'Select Date From $fromDate - $toDate'),
                              ),
                            ),
                          ),
                          SizedBox(height: 40,),
                          Text('Planning Amount',style: TextStyle(fontSize: 16),),
                          SizedBox(height: 10,),
                          TextField(
                            textAlign: TextAlign.center,
                            controller: planningAmountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(fillColor: Colors.indigo.shade50,filled: true,),
                          ),
                          SizedBox(height: 40,),
                          ElevatedButton(
                            onPressed: () {
                              var updateDate = pickedDate != null
                                  ? pickedDate.toString().split(" ")[0]
                                  : date.toString().split(" ")[0];
                              _update(itemId, planningAmountController.text,
                                  updateDate);
                            },
                            style: ButtonStyle(
                                minimumSize:
                                    MaterialStateProperty.all(Size(340, 45))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.update),
                                SizedBox(width: 5,),
                                Text('Save',style: TextStyle(fontSize: 16),),
                              ],
                            ),
                          ),
                          SizedBox(height: 30,),
                        ]),
                  ),
                );
              }
              );
  }

  _update(int itemId, String planningAmount, String planning_date) async {
    var message = await Get.find<SfaPaymentScheduleController>()
        .updatePaymentSchedule(itemId, planningAmount, planning_date);
    Fluttertoast.showToast(msg: message);
    if (!mounted) return;
    Navigator.of(context).pop();
    Get.find<SfaPaymentScheduleController>().getSfaPaymentSchedule();
  }
  
}