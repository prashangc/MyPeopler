import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/widgets.dart';

class ProductOrderReportDispatchView extends StatefulWidget {
  const ProductOrderReportDispatchView({super.key});

  @override
  State<ProductOrderReportDispatchView> createState() =>
      _ProductOrderReportDispatchViewState();
}

class _ProductOrderReportDispatchViewState
    extends State<ProductOrderReportDispatchView> {
  ProductOrderReport? _reportDetails;
  @override
  void initState() {
    _reportDetails = Get.arguments;
    getAndSetData();
    super.initState();
  }

  getAndSetData() async {
    Get.find<SfaProductListController>().customerId =
        _reportDetails!.customerId;
    Get.find<SfaProductListController>().reportDetails = _reportDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispatching Order #${_reportDetails?.orderNumber}'),
      ),
      persistentFooterButtons: [_buildDispatchButton(Get.find<SfaProductListController>().reportDetails)],
      body: GetBuilder<SfaProductListController>(builder: (controller) {
        return ListView.separated(
          itemCount: controller.reportDetails?.items?.length ?? 0,
          itemBuilder: (context, index) {
            return _items(
                controller: controller,
                index: index,
                onDelete: () {
                  Fluttertoast.showToast(
                      msg:
                          '${controller.reportDetails?.items?[index].productName} deleted',
                      backgroundColor: Colors.red);
                  controller.deleteOrderReport(index);
                });
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        );
      }),
    );
  }

  Card _items(
      {required SfaProductListController controller,
      required int index,
      required void Function()? onDelete}) {
    return Card(
      child: SizedBox(
        height: 320,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTFF(
              readOnly: true,
              hintText: 'Product Name',
              labelText: 'Product Name',
              controller: TextEditingController(
                  text:
                      '${controller.reportDetails!.items![index].productName!} - ${_reportDetails!.items![index].productCode!}'),
            ),
            CustomTFF(
              readOnly: true,
              hintText: 'Selling Price',
              labelText: 'Selling Price',
              keyboardType: TextInputType.number,
              controller: TextEditingController(
                  text:
                      controller.reportDetails!.items![index].price.toString()),
            ),
            // CustomTFF(
            //   readOnly: true,
            //   hintText: 'Available Quantity',
            //   labelText: 'Available Quantity',
            //   keyboardType: TextInputType.number,
            //   controller: TextEditingController(
            //       text: controller.reportDetails!.items![index].availableQty
            //           .toString()),
            // ),
            CustomTFF(
              readOnly: true,
              hintText: 'Ask  Quantity',
              labelText: 'Ask  Quantity',
              controller: TextEditingController(
                  text: controller.reportDetails!.items![index].askQty
                      .toString()),
              keyboardType: TextInputType.number,
            ),
            CustomTFF(
              readOnly: false,
              hintText: 'Dispatch  Quantity',
              labelText: 'Dispatch  Quantity',
              controller: TextEditingController(
                  text: controller.reportDetails!.items![index].dispatchQty ==
                          null
                      ? '0.0'
                      : controller.reportDetails!.items![index].dispatchQty
                          .toString()),
              keyboardType: TextInputType.number,
              onChanged: (data) {
                if (data != "") {
                  controller.changeDispatchQtyInProductOrderReport(
                      index, double.parse(data));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildDispatchButton(ProductOrderReport? reportDetails) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 50,
            width: 160,
            child: ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue[600])),
              onPressed: () async{
                 List<OrderDispatch> data = [];
                    for (var i = 0; i < reportDetails!.items!.length; i++) {
                      data.add(
                        OrderDispatch(
                        orderId: reportDetails.items![i].orderId,
                        id: reportDetails.items![i].id,
                        customerId: _reportDetails!.customerId,
                        status: 'partial_dispatch',
                        dispatchQuantity: reportDetails.items![i].dispatchQty !=null ?
                        reportDetails.items![i].dispatchQty.toString() :'0.0'
                      ));
                    }
                  var message = await Get.find<SfaProductListController>().dispatch(
                      data
                    );

                    MessageHelper.showInfoAlert(context: context, title: message,
                    okBtnText: 'Ok',
                    btnOkOnPress: (){
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await Get.find<SfaProductListController>()
                            .getSfaOrdersReport(
                                dispatchable: 0, type: 'subordinates');
                        Get.back();
                         Get.back();
                      });
                    });
              },
              icon: Icon(Icons.hourglass_bottom_outlined),
              label: Text(
                'Partial Dispatch',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: 160,
            child: ElevatedButton.icon(
              onPressed: () async{
                List<OrderDispatch> data = [];
                    for (var i = 0; i < reportDetails!.items!.length; i++) {
                       data.add(
                        OrderDispatch(
                        orderId: reportDetails.items![i].orderId,
                        id: reportDetails.items![i].id,
                        customerId: _reportDetails!.customerId,
                        status: 'dispatch',
                        dispatchQuantity: reportDetails.items![i].dispatchQty !=null ?
                        reportDetails.items![i].dispatchQty.toString() :'0.0'
                      ));
                    }
                  var message =  await Get.find<SfaProductListController>().dispatch(
                      data
                    );
                     MessageHelper.showInfoAlert(context: context, title: message,
                     okBtnText: 'Ok',
                     btnOkOnPress: (){
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        await Get.find<SfaProductListController>()
                            .getSfaOrdersReport(
                                dispatchable: 0, type: 'subordinates');
                        Get.back();
                         Get.back();
                      });
                    });
              },
              icon: Icon(Icons.hourglass_full_outlined),
              label: Text(
                'Full Dispatch',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> bottomSheet(
      BuildContext context, SfaProductListController controller, int index) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 40,
            // color: Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: ColorManager.primaryCol,
                              )),
                          Text(
                            'Choose Product',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
