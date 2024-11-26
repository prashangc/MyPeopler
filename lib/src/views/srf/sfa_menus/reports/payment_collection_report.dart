import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_peopler/src/controllers/sfaPaymentCollectionController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_list_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/routes.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

const subOrdinates = 'Sub ordinates';
const own = 'Own';
String type = '';
const advance_filter = 'Advance filter';

class PaymentCollectionReportView extends StatefulWidget {
  const PaymentCollectionReportView({super.key});

  @override
  State<PaymentCollectionReportView> createState() =>
      _PaymentCollectionReportState();
}

class _PaymentCollectionReportState extends State<PaymentCollectionReportView> {
  List<SfaPaymentList> _unchangableSfaPaymentList = [];
  NepaliDateTimeRange? date;
  int? subOrdinateId;

  TextEditingController? employeeFilterName;
  @override
  void initState() {
    employeeFilterName = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      DateTime now = DateTime.now();
      String todaysDate = DateFormat('yyyy-MM-dd').format(now);

      _unchangableSfaPaymentList =
          await Get.find<SfaPaymentCollectionController>().getSfaPaymentListAll(
        'subordinates',
        start: todaysDate,
        end: todaysDate,
      );
      await Get.find<SfaProductListController>().getSubOrdinates();
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
                'Payment Collection Report - ${type.toUpperCase()}',
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
                  clearFeilds();
                },
                icon: Icon(Icons.cleaning_services_rounded)),
            PopupMenuButton(
              onSelected: (value) async {
                switch (value) {
                  case subOrdinates:
                    date = null;
                    await Get.find<SfaPaymentCollectionController>()
                        .getSfaPaymentListAll('subordinates');
                    type = 'subordinates';
                    setState(() {});
                    break;
                  case own:
                    date = null;
                    DateTime now = DateTime.now();
                    String todaysDate = DateFormat('yyyy-MM-dd').format(now);
                    await Get.find<SfaPaymentCollectionController>()
                        .getSfaPaymentListAll(
                      'own',
                      end: todaysDate,
                      start: todaysDate,
                    );
                    type = 'own';
                    setState(() {});
                    break;
                  case advance_filter:
                    advanceFilter();
                    break;
                }
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
        body: Column(children: [
          CustomTFF(
              hintText: 'Search',
              labelText: 'Search',
              onChanged: (data) => search(data)),
          GetBuilder<SfaPaymentCollectionController>(builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (controller.sfaPaymentList.isEmpty) {
              return NoDataWidget();
            }
            return Expanded(
                child: ListView.builder(
              itemCount: controller.sfaPaymentList.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return SizedBox(
                  height:
                      controller.sfaPaymentList[index].status == 'pending' &&
                              type == 'subordinates'
                          ? 205
                          : 155,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                controller.sfaPaymentList[index].employeeName ??
                                    'N/A',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(2),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: controller
                                                .sfaPaymentList[index].status
                                                ?.toUpperCase() ==
                                            'APPROVED'
                                        ? Colors.green
                                        : controller.sfaPaymentList[index]
                                                    .status
                                                    ?.toUpperCase() ==
                                                'PENDING'
                                            ? Color.fromARGB(223, 222, 149, 2)
                                            : Colors.red,
                                    borderRadius: BorderRadius.circular(4)),
                                height: 20,
                                child: Text(
                                  ' ${controller.sfaPaymentList[index].status?.toUpperCase() ?? 'N/A'}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              '# ${controller.sfaPaymentList[index].refNo ?? 'N/A'}'),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              '${controller.sfaPaymentList[index].customerName ?? 'N/A'} (${controller.sfaPaymentList[index].method ?? 'N/A'})'),
                          SizedBox(
                            height: 1,
                          ),
                          Text(
                              'Rs. ${controller.sfaPaymentList[index].amount.toString()}'),
                          controller.sfaPaymentList[index].status ==
                                      'pending' &&
                                  type == 'subordinates'
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    TextButton.icon(
                                        icon: Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStateProperty.all(2),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.green)),
                                        onPressed: () async {
                                          MessageHelper.showInfoAlert(
                                              context: context,
                                              title:
                                                  'Approving #${controller.sfaPaymentList[index].refNo}',
                                              desc: 'Are you sure?',
                                              okBtnText: 'Yes',
                                              cancelBtnText: 'No',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                var message = await controller
                                                    .approvePayment(
                                                        PaymentDataStatus(
                                                            status: 'approved',
                                                            paymentId: controller
                                                                .sfaPaymentList[
                                                                    index]
                                                                .id));
                                                MessageHelper.showInfoAlert(
                                                    context: context,
                                                    title: message,
                                                    okBtnText: 'Ok',
                                                    btnOkOnPress: () async {
                                                      _unchangableSfaPaymentList =
                                                          await controller
                                                              .getSfaPaymentListAll(
                                                                  'subordinates');
                                                    });
                                              });
                                        },
                                        label: Text(
                                          'Approve',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    TextButton.icon(
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                        style: ButtonStyle(
                                            elevation:
                                                WidgetStateProperty.all(2),
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () async {
                                          MessageHelper.showInfoAlert(
                                              context: context,
                                              title:
                                                  'Rejecting #${controller.sfaPaymentList[index].refNo}',
                                              desc: 'Are you sure?',
                                              okBtnText: 'Yes',
                                              cancelBtnText: 'No',
                                              btnCancelOnPress: () {},
                                              btnOkOnPress: () async {
                                                var message = await controller
                                                    .approvePayment(
                                                        PaymentDataStatus(
                                                            status: 'rejected',
                                                            paymentId: controller
                                                                .sfaPaymentList[
                                                                    index]
                                                                .id));
                                                MessageHelper.showInfoAlert(
                                                    context: context,
                                                    title: message,
                                                    okBtnText: 'Ok',
                                                    btnOkOnPress: () async {
                                                      _unchangableSfaPaymentList =
                                                          await controller
                                                              .getSfaPaymentListAll(
                                                                  'subordinates');
                                                    });
                                              });
                                        },
                                        label: Text('Reject',
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ],
                                )
                              : SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.sfaPaymentList[index].createdAt
                                    .toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton.icon(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateColor.resolveWith(
                                              (states) =>
                                                  ColorManager.primaryCol)),
                                  onPressed: () async {
                                    File file =
                                        await controller.printPaymentSlip(
                                            controller.sfaPaymentList[index].id
                                                .toString());
                                    Get.toNamed(Routes.PDF_SCREEN,
                                        arguments: [file.path, file]);
                                  },
                                  icon: Icon(
                                    Icons.print_outlined,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Print',
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ));
          }),
        ]));
  }

  Future<void> clearFeilds() async {
    await Get.find<SfaPaymentCollectionController>()
        .getSfaPaymentListAll('subordinates');
    await Get.find<SfaProductListController>().updateDate(null, null);
    type = 'subordinates';
    date = null;
    subOrdinateId = null;
    setState(() {});
  }

  search(String searchTerm) {
    List<SfaPaymentList>? result = _unchangableSfaPaymentList.where((products) {
      String name = products.employeeName?.toLowerCase() ?? 'N/A';
      String customerName = products.customerName!.toLowerCase();
      String clientType = products.method!.toLowerCase();
      String orderNumber =
          products.refNo == null ? '' : products.refNo!.toLowerCase();
      final searchItem = searchTerm.toLowerCase();
      return name.contains(searchItem) ||
          customerName.contains(searchItem) ||
          clientType.contains(searchItem) ||
          orderNumber.contains(searchItem);
    }).toList();
    Get.find<SfaPaymentCollectionController>().searchPaymentReports(result);
  }

  void advanceFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<SfaProductListController>(builder: (pcontroller) {
            return SizedBox(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 20,
                  ),
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
                      onPressed: () async {
                        NepaliDateTime? nepaliStartDate = date?.start;
                        DateTime engDateTime = nepaliStartDate!.toDateTime();
                        String startDate =
                            "${engDateTime.year}-${engDateTime.month.toString().padLeft(2, '0')}-${engDateTime.day.toString().padLeft(2, '0')}";
                        // for end date
                        NepaliDateTime? nepaliEndDate = date?.end;
                        DateTime engEndDateTime = nepaliEndDate!.toDateTime();
                        String endDate =
                            "${engEndDateTime.year}-${engEndDateTime.month.toString().padLeft(2, '0')}-${engEndDateTime.day.toString().padLeft(2, '0')}";
                        await Get.find<SfaPaymentCollectionController>()
                            .getSfaPaymentListAll(
                          type,
                          start: startDate,
                          end: endDate,
                          employeeId: subOrdinateId,
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
}
