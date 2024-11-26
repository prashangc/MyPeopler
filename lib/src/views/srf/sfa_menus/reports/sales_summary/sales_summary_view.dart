import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/models/sfa/sfa_beat_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_customer_list_model.dart';
import 'package:my_peopler/src/models/sfa/sfa_product_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/views/srf/createCustomerView.dart';
import 'package:my_peopler/src/views/srf/sfa_menus/reports/sales_summary/sales_report_summary_view.dart';
import 'package:my_peopler/src/views/srf/srfView.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

const subOrdinates = 'Sub ordinates';
const own = 'Own';
const advance_filter = 'Advance filter';
const print_all_approved_report = 'Print all approved report';
String type = '';

class SalesSummaryView extends StatefulWidget {
  const SalesSummaryView({super.key});

  @override
  State<SalesSummaryView> createState() => _SalesSummaryViewState();
}

class _SalesSummaryViewState extends State<SalesSummaryView> {
  NepaliDateTimeRange? date;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  SfaCustomerList? _unchangableParentCustomerList;
  
  List<BeatOptionsModel>? _unchangableBeatOptionList;
  TextEditingController beatController = TextEditingController();
  TextEditingController parentController = TextEditingController();
  TextEditingController productController = TextEditingController();
  int? parentId;
  int? beatId;
  int? productId;
  int? clientId;
  List<SfaProduct>? _initialProducts;
  List<SfaProduct>? unchangableData;
  bool isLoading = false;
  TextEditingController clientTypeController = TextEditingController();

  @override
  void initState() {
    employeeFilterName = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<SfaCustomerListController>().getClientTypeOptions();
      _unchangableParentCustomerList =
          await Get.find<SfaCustomerListController>().getParentCustomer();
      _unchangableBeatOptionList =
          await Get.find<SfaCustomerListController>().getBeatOptions();
      await Get.find<SfaCustomerListController>().getSalesSummary(
          type: 'subordinates', start: NepaliDateTime.now(), end: NepaliDateTime.now());
      await Get.find<SfaProductListController>().getSubOrdinates();
          await Get.find<SfaProductListController>().getSfaProductList('');
    _initialProducts =
        Get.find<SfaProductListController>().sfaProductModel?.data;
    unchangableData =
        Get.find<SfaProductListController>().sfaProductModel?.data;
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
                'Sales Summary  - ${type.toUpperCase()}',
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
                  : Text(
                      '${NepaliDateTime.now().year}-${NepaliDateTime.now().month}-${NepaliDateTime.now().day}',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )
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
                return {subOrdinates, own, advance_filter,print_all_approved_report}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: GetBuilder<SfaCustomerListController>(builder: (controller) {
          if(isLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return _buildDashBoard(context, controller);
        }));
  }

  Future<void> showBeats(
    BuildContext context,
  ) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Choose Beat',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManager.red,
                                )),
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Beat',
                            onChanged: (data) => filterBeat(data)),
                      ])),
                  Expanded(
                    child: GetBuilder<SfaCustomerListController>(
                        builder: (controller) {
                      if (controller.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (controller.beatOptions.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 370,
                              width: MediaQuery.of(context).size.width,
                              child: NoDataWidget(),
                            ),
                          ],
                        ));
                      }
                      return ListView(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          children: controller.beatOptions.map((e) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 80,
                                  child: Card(
                                    child: ListTile(
                                      isThreeLine: false,
                                      onTap: () {
                                        beatController.text = e.name ?? '';
                                        beatId = e.id;
                                        Get.back();
                                      },
                                      title: Text(
                                        e.name ?? '',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }).toList());
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  filterBeat(String searchTerm) {
    List<BeatOptionsModel>? result =
        _unchangableBeatOptionList!.where((products) {
      String name = products.name!.toLowerCase();
      final searchItem = searchTerm.toLowerCase();
      return name.contains(searchItem);
    }).toList();
    Get.find<SfaCustomerListController>().searchBeat(result);
  }

  Future<void> clearFeilds() async {
    await Get.find<SfaCustomerListController>().getSalesSummary(
        type: 'subordinates', start: NepaliDateTime.now(), end: NepaliDateTime.now());
    await Get.find<SfaProductListController>().updateDate(null, null);
    type = 'subordinates';
    date = null;
    subOrdinateId = null;
    parentId = null;
    productId = null;
    beatId = null;
    employeeFilterName?.clear();
    parentController.clear();
    productController.clear();
    beatController.clear();
    setState(() {});
  }

  Future<void> _switchPopUpButton(String value) async {
    switch (value) {
      case subOrdinates:
        date = null;
        await Get.find<SfaCustomerListController>().getSalesSummary(
          type: 'subordinates',
        );
        type = 'subordinates';
        setState(() {});
        break;
      case own:
        date = null;
        await Get.find<SfaCustomerListController>().getSalesSummary(
          type: 'own',
        );
        type = 'own';
        setState(() {});
        break;
      case advance_filter:
        advanceFilter();
        break;
       case print_all_approved_report:
       Fluttertoast.showToast(msg: 'Generating Please Wait...');
         File file = await Get.find<SfaProductListController>()
            .getSfaOrdersReport(dispatchable: 0, type: 'subordinates',status: 'approved',exported: 1);
          Get.toNamed(Routes.PDF_SCREEN, arguments: [file.path,file]);
        break;
    }
  }

  void advanceFilter() {
    showModalBottomSheet(
       enableDrag: true,
       isScrollControlled: true,
        context: context,
        builder: (context) {
          return GetBuilder<SfaProductListController>(builder: (pcontroller) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/1.4,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15),
                    child: DateRangeButton(
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
                  ),
                   SizedBox(
                    height: 12,
                  ),
                  CustomTFF(
                    readOnly: true,
                    controller: employeeFilterName,
                    onTap: () {
                      showSubOrdinate(context, pcontroller);
                    },
                    labelText: 'Choose Subordinate',
                  ),
                   CustomTFF(
                    readOnly: true,
                    controller: clientTypeController,
                    onTap: () {
                      // Get.find<SfaCustomerListController>()
                      //     .searchParentCustomer(_unchangableParentCustomerList);
                    var controller = Get.put(SfaCustomerListController());
                     showClientTypes(context, controller, onTap);
                    },
                    labelText: 'Choose Client Type',
                  ),
                   CustomTFF(
                    readOnly: true,
                    controller: parentController,
                    onTap: () {
                      Get.find<SfaCustomerListController>()
                          .searchParentCustomer(_unchangableParentCustomerList);
                      showParentCustomer(
                        context, clientTypeController.text
                      );
                    },
                    labelText: 'Choose Customer',
                  ),
                  CustomTFF(
                    readOnly: true,
                    controller: productController,
                    onTap: () {
                      Get.find<SfaProductListController>().sfaProductModel?.data = unchangableData;
                      bottomSheet(context);
                    },
                    labelText: 'Choose Product',
                  ),
                  CustomTFF(
                    readOnly: true,
                    controller: beatController,
                    onTap: () {
                      Get.find<SfaCustomerListController>()
                          .searchBeat(_unchangableBeatOptionList);
                      showBeats(context);
                    },
                    labelText: 'Choose Beat',
                  ),
                  SubmitButton(
                      onPressed: () async {
                        await Get.find<SfaCustomerListController>()
                            .getSalesSummary(
                                type: type,
                                start: date?.start,
                                end: date?.end,
                                employeeId: subOrdinateId,
                                customerId: parentId,
                                productId: productId,
                                beatId: beatId,
                                clientId: clientId
                                );
                        // subOrdinateId = null;
                        // parentId = null;
                        // productId = null;
                        // beatId = null;
                        // employeeFilterName?.clear();
                        // parentController.clear();
                        // productController.clear();
                        // beatController.clear();
                        Get.back();
                      },
                      label: 'Filter')
                ],
              ),
            );
          });
        });
  }

  void onTap(String client, int? clientTypeID) {
   clientTypeController.text = client;
   clientId = clientTypeID;
  }

  Future<void> bottomSheet(
      BuildContext context) {
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
                          IconButton(
                              onPressed: () {
                                  Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              )),
                        ],
                      ),
                      CustomTFF(
                          hintText: 'Search Products',
                          onChanged: (value) => _searchItems(value)),
                    ],
                  ),
                ),
                _initialProducts != null
                    ? _initialProducts!.isEmpty
                        ? Center(
                            child: Text(
                            'No Products',
                            style: Theme.of(context).textTheme.displayLarge,
                          ))
                        : Expanded(
                            child: GetBuilder<SfaProductListController>(
                                builder: (controller) {
                                 
                                  return productListNormal(controller, context);
                            }),
                          )
                    : Expanded(
                        child: GetBuilder<SfaProductListController>(
                            builder: (controller) {
                            return productListNormal(controller, context);
                        }),
                      )
              ],
            ),
          ),
        );
      },
    );
  }

  void _searchItems(String value) {
      if (value == "") {
        Get.find<SfaProductListController>().searchProducts(unchangableData);
      } else {
        List<SfaProduct>? result = unchangableData!.where((products) {
          String name = products.name!.toLowerCase();
          String code = products.code!.toLowerCase();
          final searchItem = value.toLowerCase();
          return name.contains(searchItem) || code.contains(searchItem);
        }).toList();
        Get.find<SfaProductListController>().searchProducts(result);
      }
  }

  Future<void> showParentCustomer(
    BuildContext context, String client
  ) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        enableDrag: false,
        builder: (BuildContext context) {
          return SafeArea(
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 40,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                      color: Colors.white,
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Choose Customer',
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: ColorManager.red,
                                )),
                          ],
                        ),
                        CustomTFF(
                            hintText: 'Search Parent Customer',
                            onChanged: (data) => filterParentCustomerList(
                                      data, _unchangableParentCustomerList)),
                      ])),
                  Expanded(
                    child: GetBuilder<SfaCustomerListController>(
                        builder: (controller) {
                          var clientList =  controller
                          .parentCustomerList.clientLists[client] ?? [];
                      if (controller.isLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (clientList.isEmpty) {
                        return Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 370,
                              width: MediaQuery.of(context).size.width,
                              child: NoDataWidget(),
                            ),
                          ],
                        ));
                      }
                     return ListView.separated(
                      itemCount: clientList.length,
                      itemBuilder: (context, index) {
                        var client = clientList[index];
                        return SizedBox(
                        height: 80,
                        child: Card(
                             child: ListTile(
                             isThreeLine: false,
                                                     tileColor: forColorChangeMethod(
                                                        client,
                                                      ),
                                                      onTap: () {
                                                        parentController.text = client.name;
                                                        parentId = client.id;
                                                        Get.back();
                                                      },
                                                      title: Text(
                                                        client.name,
                                                      ),
                                                      subtitle: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(client.contact),
                                                          SizedBox(
                                                            height: 1,
                                                          ),
                                                          Text(client.address ?? ''),
                                                        ],
                                                      ),
                        )),
                      );},
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                             );
                    }
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget productListNormal(
      SfaProductListController controller, BuildContext context) {
    if (controller.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (controller.sfaProductModel!.data!.isEmpty) {
      return Center(
          child: Text(
        'No data found.',
        style: Theme.of(context).textTheme.displayLarge,
      ));
    }
    _initialProducts = controller.sfaProductModel?.data;
    return ListView.separated(
        itemCount: _initialProducts!.length,
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 2,
            height: 2,
          );
        },
        shrinkWrap: true,
        clipBehavior: Clip.hardEdge,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: _initialProducts![index].isSelected == true
                ? ColorManager.primaryColorLight
                : Colors.white,
            onTap: () {
              productController.text = controller.sfaProductModel?.data![index].name ?? '';
              productId = controller.sfaProductModel?.data![index].id;
              Navigator.pop(context);
            },
            title: Text(controller.sfaProductModel?.data![index].name ?? ''),
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.sfaProductModel!.data![index].code ?? ''),
                Text(
                    controller.sfaProductModel!.data![index].description ?? ''),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                    'MRP : Rs. ${controller.sfaProductModel?.data![index].price.toString()}'),
                Text(
                    'Selling Price : Rs. ${controller.sfaProductModel?.data![index].sellingPrice.toString()}'),
              ],
            ),
            isThreeLine: true,
          );
        });
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
                  title: Text(controller.subOrdinates![index].name.toString()),
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

  filterBySearchTerm(String searchTerm) {
    Map<String, List<SfaCustomerListModel>> filteredParentCustomerList = {};
    _unchangableParentCustomerList!.clientLists.forEach((key, value) {
      List<SfaCustomerListModel> filteredParentCustomers = value
          .where((customer) =>
              customer.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
              customer.contact
                  .toLowerCase()
                  .contains(searchTerm.toLowerCase()) ||
              (customer.address != null &&
                  customer.address!
                      .toLowerCase()
                      .contains(searchTerm.toLowerCase())))
          .toList();

      if (filteredParentCustomers.isNotEmpty) {
        filteredParentCustomerList[key] = filteredParentCustomers;
        Get.find<SfaCustomerListController>().searchParentCustomer(
            SfaCustomerList(clientLists: filteredParentCustomerList));
      }
    });
    if (filteredParentCustomerList.isEmpty) {
      Get.find<SfaCustomerListController>()
          .searchParentCustomer(SfaCustomerList(clientLists: {}));
    }
  }

  _buildDashBoard(BuildContext context, SfaCustomerListController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: SizedBox(
      height: 340,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.salesSummaryList.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 3 / 2.4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
              if(index == 0){
                Get.toNamed(
                Routes.SALES_REPORT_SUMMARY_VIEW,
                arguments: Params(
                  appbarTitle: 'Dispatch Summary', 
                  type: type,
                  statusType: 'dispatched',
                  start:date?.start,
                  end: date?.end,
                  subordinateId: subOrdinateId,
                  customerId: parentId,
                  productId: productId,
                  beatId: beatId,
                  ),);
              }else if(index == 1){
                 Get.toNamed(
                Routes.SALES_REPORT_SUMMARY_VIEW,
                arguments: Params(
                  appbarTitle: 'Summary', 
                  type: type,
                  start:date?.start,
                  end: date?.end,
                  subordinateId: subOrdinateId,
                  customerId: parentId,
                  productId: productId,
                  beatId: beatId,
                  ),);
              }else if(index == 2){
                  Get.toNamed(
                Routes.SALES_REPORT_SUMMARY_VIEW,
                arguments: Params(
                  appbarTitle: 'Dispatch Summary', 
                  type: type,
                  statusType: 'dispatched',
                  start:date?.start,
                  end: date?.end,
                  subordinateId: subOrdinateId,
                  customerId: parentId,
                  productId: productId,
                  beatId: beatId,
                  ),);
              }else if(index == 3){
                  Get.toNamed(
                Routes.SALES_REPORT_SUMMARY_VIEW,
                arguments: Params(
                  appbarTitle: 'Summary', 
                  type: type,
                  start:date?.start,
                  end: date?.end,
                  subordinateId: subOrdinateId,
                  customerId: parentId,
                  productId: productId,
                  beatId: beatId,
                  ),);
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: AppSize.s100,
              width: 125,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: controller.salesSummaryList[index].color,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                      color: controller.salesSummaryList[index].color)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    controller.salesSummaryList[index].name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    //  height: 10,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Text(
                      controller.salesSummaryList[index].count ?? '0',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
}



