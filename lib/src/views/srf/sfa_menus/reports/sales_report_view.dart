import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_order_report.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/views/customer_views/customerOrderListTile.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/product_order_report/product_order_report_item_view.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

const subOrdinates = 'Sub ordinates';
const own = 'Own';
const advance_filter = 'Advance filter';
String type = '';

class SalesReportView extends StatefulWidget {
  const SalesReportView({super.key});
  @override
  State<SalesReportView> createState() => _SalesReportViewState();
}

class _SalesReportViewState extends State<SalesReportView> {
  TextEditingController? searchController;
  NepaliDateTimeRange? date;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  @override
  void initState() {
    employeeFilterName = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<SfaProductListController>()
          .getSfaOrdersReport(dispatchable: 0, type: 'subordinates',statusType: 'dispatched');
      await  Get.find<SfaProductListController>().getSubOrdinates();
      type = 'subordinates';
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Sales Report - ${type.toUpperCase()}',
              style: TextStyle(fontSize: 13),
            ),
            date != null
                ? Text(
                    ' ${date!.start.year}-${date!.start.month}-${date!.start.day}   -   ${date!.end.year}-${date!.end.month}-${date!.end.day}',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                : SizedBox.shrink()
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await clearFeilds();
              },
              icon: Icon(Icons.cleaning_services_rounded)),
          PopupMenuButton(
            onSelected: (value) async {
              await _switchPopUpButton(value);
            },
            itemBuilder: (context) {
              return {subOrdinates, own, advance_filter}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          CustomTFF(
              hintText: 'Search',
              labelText: 'Search',
              controller: searchController,
              onChanged: (data) => search(data)),
          GetBuilder<SfaProductListController>(
            builder: (controller) {
              if (controller.isLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (controller.productOrderReport!.isEmpty) {
                return NoDataWidget();
              }
              return Expanded(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: controller.productOrderReport?.length,
                  itemBuilder: ((context, index) {
                    return SizedBox(
                      height: 95,
                      child: Card(
                        child: ListTile(
                          isThreeLine: false,
                          onTap: () {
                            Get.to(
                              () => ProductOrderReportItemView(
                                isCancel: 0,
                                orderId: controller
                                    .productOrderReport![index].id
                                    .toString(),
                                orderNumber: controller
                                    .productOrderReport![index].orderNumber
                                    .toString(),
                                orderStatus: controller
                                    .productOrderReport![index].status
                                    .toString(),
                                type: type,
                                totalAmount: getGrandTotal(controller
                                    .productOrderReport![index].items),
                                orderDate: controller
                                    .productOrderReport![index].createdAt!,
                                billedTo: controller.productOrderReport![index]
                                        .customerName ??
                                    '',
                                appTitle: controller
                                    .productOrderReport![index].orderNumber
                                    .toString(),
                                        clientType: controller
                                    .productOrderReport![index].clientType.toString(),
                                items: controller.productOrderReport![index]
                                        .items!.isNotEmpty
                                    ? [
                                        ...controller
                                            .productOrderReport![index].items!
                                            .map(
                                          (data) => OrderItem(
                                            productName:
                                                '${data.productName} - ${data.productCode}',
                                            qty: data.askQty.toString(),
                                            rate: data.total.toString(),
                                            availableQty:
                                                data.availableQty.toString(),
                                            sellingPrice: data.price.toString(),
                                            dispatchQty:
                                                data.dispatchQty.toString(),
                                          ),
                                        ),
                                      ]
                                    : [],
                                reportDetails:
                                    controller.productOrderReport![index],
                              ),
                            );
                          },
                          title: Text(
                            controller
                                    .productOrderReport![index].employeeName ??
                                'N/A',
                          ),
                          subtitle: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 15,),
                              Text(
                                  '${controller.productOrderReport![index].customerName ?? 'N/A'} (${controller.productOrderReport![index].clientType ?? 'N/A'})'),
                              SizedBox(
                                height: 1,
                              ),
                              Text(controller.productOrderReport![index]
                                      .customerContact ??
                                  'N/A'),
                            ],
                          ),
                          
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width:70,
                              padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color:controller.productOrderReport![index].status?.toUpperCase()=='APPROVED'? Colors.green:
                                    controller.productOrderReport![index].status?.toUpperCase()=='PENDING'
                                    ?Color.fromARGB(223, 222, 149, 2):
                                    controller.productOrderReport![index].status?.toUpperCase()=='CANCEL'?
                                    Colors.red:ColorManager.primaryOpacity70,
                                  borderRadius: BorderRadius.circular(4)),
                                height: 20,
                                child: Text(
                                    ' ${controller.productOrderReport![index].status?.toUpperCase() ?? 'N/A'}'
                                    ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                              ),
                                 SizedBox(
                                height: 2,
                              ),
                              Text(
                                  '# ${controller.productOrderReport![index].orderNumber ?? 'N/A'}'),
                                   SizedBox(
                                height: 3,
                              ),
                                   Text(
                                  'Rs. ${getGrandTotal(controller
                                    .productOrderReport![index].items)}',style: TextStyle(fontSize: 13),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> clearFeilds() async {
       await Get.find<SfaProductListController>()
        .getSfaOrdersReport(dispatchable: 0, type: 'subordinates',statusType: 'dispatched');
    await Get.find<SfaProductListController>()
        .updateDate(null, null);
    type = 'subordinates';
    date = null;
    subOrdinateId = null;
    setState(() {});
  }

  Future<void> _switchPopUpButton(String value) async {
    switch (value) {
      case subOrdinates:
        date = null;
        await Get.find<SfaProductListController>()
            .getSfaOrdersReport(dispatchable: 0, type: 'subordinates',statusType: 'dispatched');
        type = 'subordinates';
        setState(() {});
        break;
      case own:
        date = null;
        await Get.find<SfaProductListController>()
            .getSfaOrdersReport(dispatchable: 0, type: 'own',statusType: 'dispatched');
        type = 'own';
        setState(() {});
        break;
      case advance_filter:
        advanceFilter();
        break;
    }
  }

  void advanceFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<SfaProductListController>(builder: (pcontroller) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/3.2,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  DateRangeButton(
                    isNepaliDate: true,
                    nepaliDateFrom: pcontroller.startDate,
                    nepaliDateTo: pcontroller.endDate,
                    width: 1.05,
                    label: "From Date     -      To Date",
                    onTap: () async {
                      date = await showMaterialDateRangePicker(
                        context: context,
                        firstDate: NepaliDateTime(1970),
                        lastDate: NepaliDateTime(2250),
                      );
                      if (date != null) {
                        pcontroller.updateDate(date!.start, date!.end);
                        setState(() {});
                      }
                    },
                  ),
                   CustomTFF(
                      readOnly: true,
                      controller: employeeFilterName,
                      onTap: () {
                        showSubOrdinate(context, pcontroller);
                      },
                      labelText: 'Choose Subordinate',
                    ),
                    SubmitButton(
                      onPressed: (){
                        pcontroller.getSfaOrdersReport(
                          dispatchable: 0,
                           type: type,
                           start: date?.start, 
                           end:  date?.end,
                           subOrdinateId: subOrdinateId,
                           statusType: 'dispatched'
                           );
                          subOrdinateId = null;
                          employeeFilterName?.clear();
                           Get.back();
                      }, 
                      label: 'Filter')
                ],
              ),
            );
          });
        });
  }

  search(String searchTerm) {
    List<ProductOrderReport>? result = Get.find<SfaProductListController>()
        .unchangableOrderReport!
        .where((products) {
      String name = products.employeeName?.toLowerCase() ?? 'N/A';
      String customerName = products.customerName!.toLowerCase();
      String customerContact = products.customerContact!.toLowerCase();
      String clientType = products.clientType!.toLowerCase();
      String orderNumber = products.orderNumber!.toLowerCase();
      final searchItem = searchTerm.toLowerCase();
      return name.contains(searchItem) ||
          customerName.contains(searchItem) ||
          customerContact.contains(searchItem) ||
          clientType.contains(searchItem) ||
          orderNumber.contains(searchItem);
    }).toList();
    Get.find<SfaProductListController>().searchProductOrderReport(result);
  }

  getGrandTotal(List<ProductOrderReportItem>? items) {
    double sum = 0;
    for (var i = 0; i < items!.length; i++) {
      sum = sum + items[i].total!;
    }
    return sum.toDouble();
  }

  Future<void> showSubOrdinate(
      BuildContext context, SfaProductListController controller) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 3.7,
            width: MediaQuery.of(context).size.width,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
              itemCount: controller.subOrdinates?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text(controller.subOrdinates![index].name.toString()),
                  onTap: () {
                    employeeFilterName?.text =
                        controller.subOrdinates![index].name.toString();
                    subOrdinateId = controller.subOrdinates![index].id;
                    Get.back();
                  },
                );
              },
            ),
          );
        });
  }
}
