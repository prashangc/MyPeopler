import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_all_orders.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
   final refreshController = RefreshController();
   int? customerId;
   int? orderId;
   List? args;
   List<Item>? items;
   String? status;
   String? clientType;
  @override
  void initState() {
    args = Get.arguments;
    items = args![1];
    customerId = args![2];
    status = args![3];
    orderId = args![4];
    clientType = args![5];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items of Order No : ${args![0]}'),
        actions: [
        status!.toUpperCase() == 'PENDING'?  IconButton(
            onPressed: () async{
              Get.toNamed(Routes.ASK_ORDER,arguments: [customerId,'all',orderId,clientType]);
              Get.find<SfaProductListController>().customerId = customerId;
              await Get.find<SfaProductListController>().getSfaProductList('');
              await Get.find<SfaProductListController>().getSfaProductGroupList('');
              Get.find<SfaProductListController>().removeAllProducts();
              for (var i = 0; i < items!.length; i++) {
                  Get.find<SfaProductListController>().addProducts(
                  SfaProduct(
                    itemId: items![i].id,
                    id: items![i].productId,
                          code: items![i].productCode,
                          name: items![i].productName,
                          price: items![i].price!.toInt(),
                          sellingPrice: items![i].price!.toInt(),
                          availableQuantity: items![i].availableQty,
                          askQuantity: items![i].askQty,
                          isSelected: true
                        ),
                        );
              }
            },
             icon: Icon(Icons.edit_note_outlined)):SizedBox.shrink()
        ],
        ),
      body: Column(
        children: [
          _tableRow(context),
          listViewBuilder(context),
         status!.toUpperCase() == 'APPROVED' || status!.toUpperCase()=='P. DISPATCH'? Padding(
            padding: const EdgeInsets.all(6.0),
            child: 
            clientType == 'Dealer' || clientType == 'Distributor'?SizedBox.shrink():
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue[600])),
                  onPressed: () async {
                    List<OrderDispatch> data = [];
                    for (var i = 0; i < items!.length; i++) {
                      data.add(
                        OrderDispatch(
                        orderId: items![i].orderId,
                        id: items![i].id,
                        customerId: customerId,
                        status: 'partial_dispatch',
                        dispatchQuantity: items![i].dispatchQty=="" ||items![i].dispatchQty=='null'?'0':items![i].dispatchQty
                      ));
                    }
                  var message = await Get.find<SfaProductListController>().dispatch(
                      data
                    );

                    MessageHelper.showInfoAlert(context: context, title: message,
                    okBtnText: 'Ok',
                    btnOkOnPress: () async{
                        //  WidgetsBinding.instance.addPostFrameCallback((_) async {
                        //              await Get.find<SfaProductListController>()
                        //     .getSfaOrdersReport(
                        //         dispatchable: 0, type: 'subordinates');
                        //               Get.back();
                        //     });
                    });
                  }, 
                  icon: Icon(Icons.hourglass_bottom_rounded), 
                  label: Text('Partial Dispatch'),
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton.icon(
                  onPressed: () async{
                    List<OrderDispatch> data = [];
                    for (var i = 0; i < items!.length; i++) {
                      data.add(OrderDispatch(
                        orderId: items![i].orderId,
                        id: items![i].id,
                        customerId: customerId,
                        status: 'dispatch',
                        dispatchQuantity: items![i].dispatchQty
                      ));
                    }
                  var message =  await Get.find<SfaProductListController>().dispatch(
                      data
                    );
                     MessageHelper.showInfoAlert(
                      context: context, title: message,
                      okBtnText: 'Ok',
                      btnOkOnPress: () async{
                            //         WidgetsBinding.instance.addPostFrameCallback((_) async {
                            //          await Get.find<SfaProductListController>()
                            // .getSfaOrdersReport(
                            //     dispatchable: 0, type: 'subordinates');
                            //         Get.back();
                            // });
                    });
                  }, 
                  icon: Icon(Icons.hourglass_full_outlined), 
                  label: Text('Full Dispatch')),
                ),
              ],
            ),
          ):SizedBox.shrink()
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
                  'Product'.toUpperCase(),
                 style: TextStyle(color: Colors.white,fontSize: 13),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'Avlb QT'.toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 13),
                )),
                 SizedBox(
                width: MediaQuery.of(context).size.width / 6,
                child: Text(
                  'Ask Qt'.toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 13),
                )),
                 SizedBox(
                width: MediaQuery.of(context).size.width / 8,
                child: Text(
                  'Price'.toUpperCase(),
                  style: TextStyle(color: Colors.white,fontSize: 13),
                )),
            Text(
              'Tot'.toUpperCase(),
              style: TextStyle(color: Colors.white,fontSize: 13),
            ),
             Text(
              'Disp Qt'.toUpperCase(),
             style: TextStyle(color: Colors.white,fontSize: 13),
            ),
        
          ],
        ),
      ),
    );
  }

  listViewBuilder(BuildContext context) {
       if (items!.isEmpty) {
          return NoDataWidget();
        }
        return Expanded(
          child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: items!.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    color: index.isOdd ? ColorManager.creamColor : ColorManager.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Text('${items![index].productName} (${items![index].productCode})',textAlign: TextAlign.start,),),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                              child: Text(
                                items![index].availableQty.toString(),
                                textAlign: TextAlign.start,
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width /8,
                              child: Text(
                               items![index].askQty.toString(),
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 8,
                              child:Text(items![index].price.toString(),textAlign: TextAlign.end,),
                              ),
                              SizedBox(
                              width: MediaQuery.of(context).size.width / 10,
                              child: Text(items![index].total.toString() ,
                              textAlign: TextAlign.end,
                              )),
                            status!.toUpperCase() == 'APPROVED' || 
                            status!.toUpperCase() == 'P. DISPATCH'?  
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 8.0,
                              child: TextFormField(
                                readOnly: false,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (data){
                                  items![index].dispatchQty = data;
                                },
                                controller: TextEditingController(text: 
                                items![index].dispatchQty.toString() == 'null'?'N/A':
                              items![index].dispatchQty.toString()
                              ),
                              ),
                              )
                            :SizedBox(
                              width: MediaQuery.of(context).size.width / 7,
                              child: 
                              Text(items![index].dispatchQty.toString() == 'null'?'N/A':
                              items![index].dispatchQty.toString() ,
                              textAlign: TextAlign.center,
                              ),
                              ),
                        ],
                      ),
                    ),
                  );
                },
              ),
        );
      }
  }
