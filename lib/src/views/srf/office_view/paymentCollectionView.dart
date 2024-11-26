import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaPaymentCollectionController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class PaymentCollectionView extends StatefulWidget {
  const PaymentCollectionView({super.key});
  @override
  State<PaymentCollectionView> createState() => _PaymentCollectionViewState();
}

class _PaymentCollectionViewState extends State<PaymentCollectionView> {

  TextEditingController? amountController = TextEditingController();
  TextEditingController? methodController = TextEditingController();
  TextEditingController? methodIdController = TextEditingController();
  TextEditingController? referenceNumberController = TextEditingController();
  TextEditingController? notesController = TextEditingController();

  @override
  void initState() {
    Get.find<SfaPaymentCollectionController>().customerId = Get.arguments;
    Get.find<SfaPaymentCollectionController>().getSfaPaymentList();
    Get.find<SfaPaymentCollectionController>().getSfaPaymentMethod();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Collection'),
        actions: [
          IconButton(
            onPressed: () {
              bottomSheet(context);
              
            },
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
        
          _tableRow(context),
          listViewBuilder(context)
        ],
      ),
    );
  }

  _tableRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        color: ColorManager.lightPurple2,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5.5,
                  child: Text(
                    'REF NO'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 5,
                  child: Text(
                    'METHOD'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              Text(
                'amount'.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                'status'.toUpperCase(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }

  listViewBuilder(BuildContext context) {
    return GetBuilder<SfaPaymentCollectionController>(
      builder: (controller) {
        if (controller.sfaPaymentList.isEmpty) {
          return NoDataWidget();
        }else if(controller.isLoading){
          return LinearProgressIndicator();
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height/1.21,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: controller.sfaPaymentList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async{
                  File file =  await controller.printPaymentSlip(controller.sfaPaymentList[index].id.toString());
                  Get.toNamed(Routes.PDF_SCREEN,arguments: [file.path,file]);
                },
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  color: index.isOdd ? ColorManager.creamColor : ColorManager.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: Text(controller.sfaPaymentList[index].refNo ??
                                'No data')),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Text(
                              controller.sfaPaymentList[index].method ?? '',
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Text(
                              controller.sfaPaymentList[index].amount.toString(),
                              textAlign: TextAlign.center,
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width / 8,
                            child: Text(controller.sfaPaymentList[index].status ?? 'N/A')),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<void> showPaymentMethods(
      BuildContext context,) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      
      builder: (BuildContext context) {
        return GetBuilder<SfaPaymentCollectionController>(
          builder: (controller) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/2.2,
              width: MediaQuery.of(context).size.width,
              child: ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) {
                  return Divider(thickness: 2,);
                },
                itemCount: controller.sfaPaymentMethods.length,
                itemBuilder: (context,index){
                  return ListTile(
                    title: Text(controller.sfaPaymentMethods[index].name.toString()),
                    onTap: (){
                      methodController?.text = controller.sfaPaymentMethods[index].name.toString();
                      methodIdController?.text = controller.sfaPaymentMethods[index].id.toString();
                      Get.back();
                    },
                    );
                },),
            );
          }
        );});}

  Future<void> bottomSheet(
      BuildContext context,) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height/2.2,
              width: MediaQuery.of(context).size.width,
              // color: Colors.amber,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
              CustomTFF(
               labelText: 'Amount',
               hintText: 'Amount',
               
               controller: amountController,
               vPad: 8,
               keyboardType: TextInputType.number),
                CustomTFF(
                  labelText: 'Method',
                  hintText: 'Method',
                    vPad: 8,
                    readOnly: true,
                    onTap: (){
                      showPaymentMethods(context);
                    },
                  controller: methodController,
                ),
                  
                CustomTFF(
                  labelText: 'REF No',
                  hintText: 'REF No',
                    vPad: 8,
                  controller: referenceNumberController,
                ),
                CustomTFF(
                  labelText: 'Notes',
                  hintText: 'Notes',
                    vPad: 8,
                  controller: notesController,
                ),
                SizedBox(height: 8,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                               onPressed: (){
          
                               Get.find<SfaPaymentCollectionController>()
                   .postSfaPaymentList(
                     PaymentData(
                       amount: amountController?.text,
                       method: methodIdController?.text,
                       refNo: referenceNumberController?.text,
                       customerId: Get.find<SfaPaymentCollectionController>().customerId.toString(),
                       notes: notesController?.text
                   ));
                           Get.back();
                   amountController?.clear();
                   methodController?.clear();
                   methodIdController?.clear();
                   referenceNumberController?.clear();
                   notesController?.clear();
                    }, child: Text('Submit')),
                  ),
                )
                ],
              ))),
        );});}
}
