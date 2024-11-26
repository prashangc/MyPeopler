import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';

class PaymentScheduleList extends StatefulWidget {
  const PaymentScheduleList({super.key});

  @override
  State<PaymentScheduleList> createState() => _PaymentScheduleListState();
}

class _PaymentScheduleListState extends State<PaymentScheduleList> {
  final title = Get.arguments['title'];
  final datum = Get.arguments['datum'];
  final scheduleIndex = Get.arguments['index'];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.separated(
            itemBuilder:(context, index) {
              var paymentScheduleApi = datum.items[index];
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.PAYMENT_SCHEDULE_PLANS,
                   arguments: {
                      'customerTitle': paymentScheduleApi.customerName,
                      'paymentScheduleApi': paymentScheduleApi, 'itemIndex': index, 'index': scheduleIndex, 'dateApi': datum
                    }
                    );
                },
                child: SizedBox(
                  height: 150,
                  child: Card(
                  color: ColorManager.lightGreen2,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 8),
                     child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Center(
                           child: Text(paymentScheduleApi.customerName,
                           style: Theme.of(context).textTheme.titleLarge,),
                         ),
                        Text('Due Amount: Rs.${paymentScheduleApi.dueAmount}',
                                    style: Theme.of(context).textTheme.displaySmall,),
                         Text('Due Day: ${paymentScheduleApi.dueDay}',
                                    style: Theme.of(context).textTheme.displaySmall,),
                          Text('Planning Amount: Rs.${paymentScheduleApi.planningAmount}',
                                    style: Theme.of(context).textTheme.displaySmall,),
                       ],
                     ),
                   )),
                ),
              );
            }, 
            separatorBuilder:(context, index) => SizedBox(height: 15,),
            itemCount: datum.items.length ?? 0)
    );
  }
}