
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaPaymentScheduleController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PaymentSchedule extends StatefulWidget {
  const PaymentSchedule({super.key});

  @override
  State<PaymentSchedule> createState() => _PaymentScheduleState();
}

class _PaymentScheduleState extends State<PaymentSchedule> {
  RefreshController refreshController = RefreshController();
  final RefreshController _refreshController = RefreshController();
   @override
  void initState() {
    Get.find<SfaPaymentScheduleController>().getSfaPaymentSchedule();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Payment Schedule'),
      ),
      body: GetBuilder<SfaPaymentScheduleController>(builder: (controller) {
        if (controller.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.sfaPaymentSchedule!.isEmpty) {
          return SmartRefresher(
            controller: _refreshController,
          onRefresh: () {
            Get.find<SfaPaymentScheduleController>().getSfaPaymentSchedule();
            _refreshController.refreshCompleted();
          },
            child: NoDataWidget(
              title: 'No Payment Schedule.',
            ),
          );
        }
        return SmartRefresher(
          controller: refreshController,
          onRefresh: () {
            Get.find<SfaPaymentScheduleController>().getSfaPaymentSchedule();
            refreshController.refreshCompleted();
          },
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.sfaPaymentSchedule?.length,
            itemBuilder: (context, index) {
              var sfaPaymentScheduleData =
                  controller.sfaPaymentSchedule?[index];
              var totalDueAmount = sfaPaymentScheduleData?.items.fold(0, (previousValue, element) => previousValue + element.dueAmount);
              var totalPlanningAmount = sfaPaymentScheduleData?.items.fold(0, (previousValue, element) => (previousValue + (element.planningAmount ?? 0) ));
            var nepaliFromDate = sfaPaymentScheduleData?.fromDate;
            var nepaliToDate = sfaPaymentScheduleData?.toDate;
              return SizedBox(
                height: 150,                   
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.PAYMENT_SCHEDULE_LIST, arguments: {
                      'title': sfaPaymentScheduleData?.title, 'datum': sfaPaymentScheduleData, 'index': index, 
                    });
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                    ),
                    color: ColorManager.creamColor,
                    margin: EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                            child: Text( sfaPaymentScheduleData?.title ?? "",
                                style: Theme.of(context).textTheme.titleLarge,),
                          ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Text('From: $nepaliFromDate',
                                      style: Theme.of(context).textTheme.displaySmall,),
                        Text('To: $nepaliToDate',
                                      style: Theme.of(context).textTheme.displaySmall,),
                        ],),
                        SizedBox(height: 10,),
                        Text('Total Due Amount: Rs.$totalDueAmount',style: Theme.of(context).textTheme.displaySmall,),
                        SizedBox(height: 10,),  
                        Text('Total Planning Amount: Rs.$totalPlanningAmount',style: Theme.of(context).textTheme.displaySmall,),           
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
