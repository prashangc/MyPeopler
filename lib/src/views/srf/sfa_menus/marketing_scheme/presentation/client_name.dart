import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClientName extends StatefulWidget {
  const ClientName({super.key});

  @override
  State<ClientName> createState() => _ClientNameState();
}

class _ClientNameState extends State<ClientName> {
  final clientName = Get.arguments[1];
  final clientTypeName = Get.arguments[2];
  final clientID = Get.arguments[0];
  RefreshController refreshcontroller = RefreshController();
  final RefreshController _refreshcontroller = RefreshController();

  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) async{
     await Get.find<SfaProductListController>().getSfaMarketScheme(clientID);
     });
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
     return SmartRefresher(
      controller: _refreshcontroller,
      onRefresh: () {
        Get.find<SfaProductListController>().getSfaMarketScheme(clientID);
        _refreshcontroller.refreshCompleted();
      },
    child:  Scaffold(
      appBar: AppBar(
        title: Text(clientName),
        centerTitle: true,
      ),
      body: GetBuilder<SfaProductListController>(builder: (controller) {
        var response = controller.newPriceView;
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.newPriceView.isEmpty) {
            return NoDataWidget();
          }
          return SmartRefresher(
            controller: refreshcontroller,
            onRefresh: (){
              Get.find<SfaProductListController>().getSfaMarketScheme(clientID);
              refreshcontroller.refreshCompleted();
            },
     child: ListView.separated(
      shrinkWrap: true,
     itemBuilder:(context, index) {
      var status = response[index].status;
       return   InkWell(
         onTap: () {
          //  Get.toNamed(Routes.New_Product_Price, arguments: [response[index].items, response[index].title, response[index].customers]);
         },
         child: SizedBox(
          height: 120,
           child: Card(
             child: Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8),
               child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Center(child: Text(response[index].title,style: TextStyle(fontSize: 18),)),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('From: ${response[index].fromDate}'),
                         SizedBox(height: 10,),
                         Text('To: ${response[index].toDate}'),
                       ],
                      ),
                        Container(
                        width: 80,
                        height: 20,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: status == 'pending'? Colors.redAccent : Colors.green),
                        child: Center(child: Text(status,style: TextStyle(color: Colors.white),))),
                     ],
                   ),
                 ],
               ),
             ),
           ),
         ),
       );
     }, 
     separatorBuilder:(context, index) => SizedBox(height: 10,), itemCount: response.length),);}),

      floatingActionButton: FloatingActionButton(
            onPressed: () {
             Get.toNamed(Routes.CREATE_PRODUCT_PRICE, arguments: [clientID, clientTypeName]);
            }, 
            backgroundColor: ColorManager.primaryColorLight,
            child: Icon(Icons.add,size: 30,)),
    ),);
  }
}