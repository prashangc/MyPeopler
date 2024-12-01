import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/resources/values_manager.dart';

import '../../../core/core.dart';
import '../../../routes/routes.dart';

class Options {
  String name;
  Icon? icon;
  Color color;
  void Function()? onTap;
  String? count;
  Options(
      {required this.name,
      required this.color,
      this.icon,
      this.onTap,
      this.count});
}

class SfaMenu extends StatefulWidget {
  const SfaMenu({super.key});

  @override
  State<SfaMenu> createState() => _SfaMenuState();
}

class _SfaMenuState extends State<SfaMenu> {
  int totalCustomerToday = 0;
  int totalCustomerAll = 0;
  bool showAllFloationActionButtons = false;

  List<Options> general = [
    Options(
      name: 'Today Assigned Party',
      color: ColorManager.strawBerryColor,
      icon: Icon(
        Icons.today_outlined,
        size: 40,
      ),
    ),
    Options(
        name: 'Total Assigned Party',
        color: ColorManager.lightGreen,
        icon: Icon(
          Icons.restart_alt_outlined,
          size: 40,
        )),
    Options(
      name: 'Total Orders',
      color: ColorManager.orangeColor,
      icon: Icon(
        Icons.shopify_outlined,
        size: 40,
      ),
    ),
    Options(
      name: 'Tour Plan',
      color: Colors.green,
      icon: Icon(
        Icons.tour_outlined,
        size: 40,
      ),
    ),
    Options(
      name: 'Payment Schedule',
      color: ColorManager.purpleColor,
      icon: Icon(
        Icons.payment,
        size: 40,
      ),
    ),
    Options(
      name: 'Location Log',
      color: ColorManager.red,
      icon: Icon(
        Icons.location_history,
        size: 40,
      ),
    ),
    Options(
      name: 'Marketing Scheme',
      color: ColorManager.orangeColor,
      icon: Icon(
        Icons.shop,
        size: 40,
      ),
    ),
  ];

  List<Options> reports = [
    Options(
        name: 'Order Report',
        color: ColorManager.strawBerryColor,
        icon: Icon(
          Icons.pie_chart_outline_outlined,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.PRODUCT_ORDER_REPORT_VIEW);
        }),
    Options(
        name: 'Payment Collection Report',
        color: ColorManager.lightGreen,
        icon: Icon(
          Icons.trending_up_outlined,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.PAYMENT_COLLECTION_REPORT_VIEW);
        }),
    Options(
        name: 'Tour Plan Report',
        color: ColorManager.orangeColor,
        icon: Icon(
          Icons.travel_explore_outlined,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.TOUR_PLAN_REPORT_VIEW);
        }),
    Options(
        name: 'Sales Report',
        color: Colors.green,
        icon: Icon(
          Icons.bar_chart_outlined,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.SALES_REPORT_VIEW);
        }),
    Options(
        name: 'Sales Summary',
        color: ColorManager.creamColor2,
        icon: Icon(
          Icons.summarize_outlined,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.SALES_SUMMARY_VIEW);
        }),
    //TODO:[SPANDAN] Expenditure
    Options(
        name: 'Expenditure',
        color: ColorManager.purpleColor,
        icon: Icon(
          Icons.attach_money_rounded,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.EXPENDITURE_VIEW);
        }),
    Options(
        name: 'Estimated Customer Report',
        color: ColorManager.orangeColor2,
        icon: Icon(
          Icons.report,
          size: 40,
        ),
        onTap: () {
          Get.toNamed(Routes.ESTIMATED_CUSTOMER_REPORT);
        }),
  ];
  bool? boolValue;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<SfaCustomerListController>().getSfaDashBoardData();
      await Get.find<SfaCustomerListController>().getSfaCustomerList('daily');
      await Get.find<SfaCustomerListController>().getSfaCustomerList('all');
    });
  }

  isServiceRunning() async {
    boolValue = await FlutterBackgroundService().isRunning();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: ListTile(
          leading: Image.asset(
            MyAssets.sfa,
            height: 40,
            width: 40,
          ),
          title: Text(
            'SFA',
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text('Sales Force Automation',
              style: TextStyle(color: Colors.white)),
          isThreeLine: false,
        ),
        actions: [
          Platform.isAndroid
              ? GetBuilder<SfaLocationLogsController>(builder: (controller) {
                  if (controller.isLoading) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Colors.white,
                      )),
                    );
                  }
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: IconButton(
                        onPressed: () {
                          MessageHelper.showInfoAlert(
                              context: context,
                              title: 'Syncing your location logs',
                              desc: 'Do you want to sync your location log?',
                              okBtnText: 'Yes',
                              cancelBtnText: 'No',
                              btnCancelOnPress: () {
                                //Get.back();
                              },
                              btnOkOnPress: () async {
                                BaseResponse data = await controller
                                    .convertListStringToSfaLocationModel(
                                  isCheckIn: null,
                                );
                                if (data.status == 'success') {
                                  MessageHelper.showSuccessAlert(
                                      context: context,
                                      title: 'Data Synced',
                                      desc: data.data,
                                      okBtnText: 'Ok',
                                      btnOkOnPress: () async {});
                                } else if (data.status == 'error') {
                                  MessageHelper.errorDialog(
                                    context: context,
                                    errorMessage: data.data,
                                    btnOkText: 'Ok',
                                    btnOkOnPress: () {},
                                  );
                                }
                              });
                        },
                        icon: Icon(
                          Icons.cloud_sync_outlined,
                          size: 35,
                        )),
                  );
                })
              : SizedBox.shrink()
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //  GetBuilder<SfaCustomerListController>(builder: (controller)
                //  {
                //   return _buildDashBoard(context,controller);
                //  }),
                Text(
                  'General',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12),
                _buildGeneralOptions(context),
                // SizedBox(
                //   height: 8,
                // ),
                Text(
                  'Reports',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 12),
                _buildReportOptions(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildGeneralOptions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: SizedBox(
          // height: 380, //350,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: general.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Get.toNamed(Routes.SRF_PAGE,
                        arguments: ['daily', 'officeView']);
                  } else if (index == 1) {
                    // Get.toNamed(Routes.SRF_PAGE,
                    //     arguments: ['all', 'officeView']);
                  } else if (index == 2) {
                    Get.toNamed(Routes.SRF_PAGE,
                        arguments: ['all', 'orderView']);
                  } else if (index == 3) {
                    Get.toNamed(Routes.TOUR_PLAN);
                  } else if (index == 4) {
                    Get.toNamed(Routes.PAYMENT_SCHEDULE);
                  } else if (index == 5) {
                    Get.toNamed(Routes.LOCATION_LOG);
                  } else if (index == 6) {
                    Get.toNamed(Routes.Client_Detail);
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: AppSize.s100,
                  width: 125,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: general[index].color,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: general[index].color)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      general[index].icon ?? SizedBox.shrink(),
                      Text(
                        general[index].name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      index == 0
                          ? GetBuilder<SfaCustomerListController>(
                              builder: (controller) {
                              totalCustomerToday = 0;
                              for (var e in controller
                                  .sfaCustomerList.clientLists.entries) {
                                totalCustomerToday =
                                    totalCustomerToday + e.value.length;
                              }
                              return Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Container(
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5))),
                                    child: Text(
                                      totalCustomerToday.toString(),
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              );
                            })
                          : index == 1
                              ? GetBuilder<SfaCustomerListController>(
                                  builder: (controller) {
                                  totalCustomerAll = 0;
                                  for (var e in controller
                                      .sfaCustomerListAll.clientLists.entries) {
                                    totalCustomerAll =
                                        totalCustomerAll + e.value.length;
                                  }
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        width: 100,
                                        decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5))),
                                        child: Text(
                                          totalCustomerAll.toString(),
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  );
                                })
                              : SizedBox.shrink()
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildReportOptions(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
        child: SizedBox(
          // height: 350, //350,
          child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: reports.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 3 / 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: reports[index].onTap,
                child: Container(
                  alignment: Alignment.center,
                  height: AppSize.s100,
                  width: 125,
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      color: reports[index].color,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(color: reports[index].color)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      reports[index].icon ?? SizedBox.shrink(),
                      Text(
                        reports[index].name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildDashBoard(BuildContext context, SfaCustomerListController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
      child: SizedBox(
        //color: Colors.red,
        height: 330,
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.dashBoardData.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 3 / 2.4,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: controller.dashBoardData[index].onTap,
              child: Container(
                alignment: Alignment.center,
                height: AppSize.s100,
                width: 125,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: controller.dashBoardData[index].color,
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                        color: controller.dashBoardData[index].color)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      controller.dashBoardData[index].name,
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
                        controller.dashBoardData[index].count.toString(),
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
