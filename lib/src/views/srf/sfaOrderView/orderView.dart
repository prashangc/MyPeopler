import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
   final refreshController = RefreshController();
   String? name;
   String? contact;
   String? clientType;
  @override
  void initState() {
     Get.find<SfaProductListController>().customerId = Get.arguments[0];
     name = Get.arguments[1];
     contact = Get.arguments[2];
     clientType = Get.arguments[3];
    Get.find<SfaProductListController>().getSfaOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SFA Orders'),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name ?? '',style: TextStyle(fontSize:12),),
              SizedBox(width: 5,),
              Text('($contact) ($clientType)',style: TextStyle(fontSize:12),),
            ],
          )
        ],
      ),),
      body: Column(
        children: [
          _tableRow(context),
          listViewBuilder(context)
        ],
      ),
    );
  }

  _tableRow(BuildContext context) {
    return Container(
      color: ColorManager.primaryColorLight,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'Ord No'.toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 14),
                )),
                 SizedBox(
                width: MediaQuery.of(context).size.width / 8,
                child: Text(
                  'Total'.toUpperCase(),
                   style: TextStyle(color: Colors.white,fontSize: 14),
                )),
            Text(
              'Status'.toUpperCase(),
               style: TextStyle(color: Colors.white,fontSize: 14),
            ),
        
          ],
        ),
      ),
    );
  }

  listViewBuilder(BuildContext context) {
    return GetBuilder<SfaProductListController>(
      builder: (controller) {
        if(controller.isLoading){
          return Center(child: CircularProgressIndicator());
        }
        else if (controller.sfaOrders!.isEmpty) {
          return NoDataWidget();
        }
        return SizedBox(
           height: MediaQuery.of(context).size.height/1.21,
          child: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          Get.find<SfaProductListController>().customerId = Get.arguments[0];
          Get.find<SfaProductListController>().getSfaOrders();
          refreshController.refreshCompleted();
        },
        
        child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: controller.sfaOrders!.length,
              itemBuilder: (context, index) {
                if(controller.sfaOrders![index].status != 'dispatch'){
                  return InkWell(
                  onTap: (){
                    // .. //
                    Get.toNamed(Routes.ITEM_VIEW,arguments: [ 
                      controller.sfaOrders![index].orderNumber,
                      controller.sfaOrders![index].items,
                      Get.arguments[0],
                      controller.sfaOrders![index].status,
                      controller.sfaOrders![index].id,
                      Get.arguments[3]  
                      ],);
                    // .. //
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
                              width: MediaQuery.of(context).size.width / 5.5,
                              child: Text(controller.sfaOrders![index].orderNumber ?? '')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              height: 70,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(controller.sfaOrders![index].total.toString(),textAlign: TextAlign.center,),
                              )),
                              Container(
                                width:65,
                              padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:controller.sfaOrders![index].status?.toUpperCase()=='APPROVED'? Colors.green:
                                    controller.sfaOrders![index].status?.toUpperCase()=='PENDING'
                                    ?Color.fromARGB(223, 222, 149, 2):
                                    controller.sfaOrders![index].status?.toUpperCase()=='CANCEL'?
                                    Colors.red:ColorManager.primaryOpacity70,
                                  borderRadius: BorderRadius.circular(4)),
                                height: 20,
                                child: Text(
                                    ' ${controller.sfaOrders![index].status?.toUpperCase() ?? 'N/A'}',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                             
                        ],
                        ),
                      ),
                    ),
                  );
                }else{
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        );
      },
    );
  }
}