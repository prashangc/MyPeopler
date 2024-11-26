import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/helpers/messageHelper.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const subOrdinates = 'Sub ordinates';
const own = 'Own';
String type = '';
const advance_filter = 'Advance filter';

class TourPlanReport extends StatefulWidget {
  const TourPlanReport({super.key});
  @override
  State<TourPlanReport> createState() => _TourPlanState();
}

class _TourPlanState extends State<TourPlanReport> {
  RefreshController refreshcontroller = RefreshController();
  final RefreshController _refreshcontroller = RefreshController();
  // TextEditingController _noteController = TextEditingController();
  NepaliDateTimeRange? date;
  NepaliDateTime? startFrom;
  NepaliDateTime? endTo;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  bool isTourplanReport = true;
  @override
  void initState() {
    employeeFilterName = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<SfaTourPlanController>().getSfaAllTourPlan(
          type: 'subordinates',
          start: MyDateUtils.getNepaliDateOnly(
            NepaliDateTime.now(),
          ),
          end: MyDateUtils.getNepaliDateOnly(NepaliDateTime.now()));
      await Get.find<SfaProductListController>().getSubOrdinates();
      Get.find<ProfileController>().getProfile();
      setState(() {
        type = 'subordinates';
      });
    });
    super.initState();
  }

 int? getUserID() {
    var controller = Get.put(ProfileController());
    return controller.user?.id;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshcontroller,
      onRefresh: () {
        if (type == 'subordinates') {
          Get.find<SfaTourPlanController>().getSfaAllTourPlan(
              type: type,
              start: MyDateUtils.getNepaliDateOnly(
                NepaliDateTime.now(),
              ),
              end: MyDateUtils.getNepaliDateOnly(NepaliDateTime.now()));
        } else {
          Get.find<SfaTourPlanController>().getSfaAllTourPlan(type: 'own');
        }
        _refreshcontroller.refreshCompleted();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text('Tour Plan Report - ${type.toUpperCase()}',
                  style: TextStyle(fontSize: 13)),
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
                    await Get.find<SfaTourPlanController>().getSfaAllTourPlan(
                        type: 'subordinates',
                        start: MyDateUtils.getNepaliDateOnly(
                          NepaliDateTime.now(),
                        ),
                        end: MyDateUtils.getNepaliDateOnly(
                            NepaliDateTime.now()));
                    type = 'subordinates';
                    setState(() {});
                    break;
                  case own:
                    date = null;
                    await Get.find<SfaTourPlanController>()
                        .getSfaAllTourPlan(type: 'own');
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
        body: GetBuilder<SfaTourPlanController>(builder: (controller) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.sfaTourPlans.isEmpty) {
            return NoDataWidget(
              title: 'No Tour Plan Added.',
            );
          }
          return SmartRefresher(
            controller: refreshcontroller,
            onRefresh: () {
              if (type == 'subordinates') {
                Get.find<SfaTourPlanController>().getSfaAllTourPlan(
                    type: type,
                    start: MyDateUtils.getNepaliDateOnly(
                      NepaliDateTime.now(),
                    ),
                    end: MyDateUtils.getNepaliDateOnly(NepaliDateTime.now()));
              } else {
                Get.find<SfaTourPlanController>()
                    .getSfaAllTourPlan(type: 'own');
              }
              refreshcontroller.refreshCompleted();
            },
            child: ListView.builder(
                itemCount: controller.sfaTourPlans.length, 
                itemBuilder: (context, index) {
                  var employeeId = controller.sfaTourPlans[index].createdBy;
                 return  employeeId != getUserID()? InkWell(
                    onTap: () {
                      Get.toNamed(Routes.TOUR_PLAN_DETAIL_VIEW,
                          arguments: [controller.sfaTourPlans[index], true, isTourplanReport]);
                    },
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.sfaTourPlans[index]
                                                .createdByName ??
                                            "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: controller
                                                        .sfaTourPlans[index]
                                                        .status
                                                        ?.toUpperCase() ==
                                                    'APPROVED'
                                                ? Colors.green
                                                : controller.sfaTourPlans[index]
                                                            .status
                                                            ?.toUpperCase() ==
                                                        'PENDING'
                                                    ? Colors.orange
                                                    : controller
                                                                .sfaTourPlans[
                                                                    index]
                                                                .status
                                                                ?.toUpperCase() ==
                                                            'COMPLETED'
                                                        ? const Color(
                                                            0xffd3af37)
                                                        : Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(4)),
                                        height: 20,
                                        child: Text(
                                          ' ${controller.sfaTourPlans[index].status?.toUpperCase() ?? 'N/A'}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    controller.sfaTourPlans[index].title ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'From: ${controller.sfaTourPlans[index].startFrom}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        'To: ${controller.sfaTourPlans[index].endTo}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    'Tour day: ${controller.sfaTourPlans[index].tourDays.toString()}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  controller.sfaTourPlans[index].status ==
                                              'pending' &&
                                          type == 'subordinates'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton.icon(
                                                icon: Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                                style: ButtonStyle(
                                                    elevation:
                                                        WidgetStateProperty.all(
                                                            2),
                                                    backgroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.green)),
                                                onPressed: () async {
                                                  MessageHelper.showInfoAlert(
                                                    context: context,
                                                    title:
                                                        'Approving Tour Plan of ${controller.sfaTourPlans[index].createdByName}',
                                                    desc: 'Are you sure?',
                                                    okBtnText: 'Yes',
                                                    cancelBtnText: 'No',
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () async {
                                                      var message =
                                                          await controller
                                                              .approveTourPlan(
                                                                  TourPlanData(
                                                        status: 'approved',
                                                        tourPlanId: controller
                                                            .sfaTourPlans[index]
                                                            .id,
                                                      ));

                                                      MessageHelper
                                                          .showInfoAlert(
                                                              context: context,
                                                              title: message,
                                                              okBtnText: 'Ok',
                                                              btnOkOnPress:
                                                                  () async {
                                                                await controller
                                                                    .getSfaAllTourPlan(
                                                                        type:
                                                                            'subordinates',
                                                                        start: MyDateUtils
                                                                            .getNepaliDateOnly(
                                                                          NepaliDateTime
                                                                              .now(),
                                                                        ),
                                                                        end: MyDateUtils.getNepaliDateOnly(
                                                                            NepaliDateTime.now()));
                                                              });
                                                    },
                                                  );
                                                },
                                                label: Text(
                                                  'Approve',
                                                  style: TextStyle(
                                                      color: Colors.white),
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
                                                      WidgetStateProperty.all(
                                                          2),
                                                  backgroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.red)),
                                              onPressed: () async {
                                                MessageHelper.showInfoAlert(
                                                    context: context,
                                                    title:
                                                        'Rejecting Tour Plan of ${controller.sfaTourPlans[index].createdByName}',
                                                    desc: 'Are you sure?',
                                                    okBtnText: 'Yes',
                                                    cancelBtnText: 'No',
                                                    btnCancelOnPress: () {},
                                                    btnOkOnPress: () async {
                                                      var message =
                                                          await controller
                                                              .approveTourPlan(
                                                                  TourPlanData(
                                                        status: 'rejected',
                                                        tourPlanId: controller
                                                            .sfaTourPlans[index]
                                                            .id,
                                                      ));
                                                      MessageHelper
                                                          .showInfoAlert(
                                                              context: context,
                                                              title: message,
                                                              okBtnText: 'Ok',
                                                              btnOkOnPress:
                                                                  () async {
                                                                await controller
                                                                    .getSfaAllTourPlan(
                                                                        type:
                                                                            'subordinates',
                                                                        start: MyDateUtils
                                                                            .getNepaliDateOnly(
                                                                          NepaliDateTime
                                                                              .now(),
                                                                        ),
                                                                        end: MyDateUtils.getNepaliDateOnly(
                                                                            NepaliDateTime.now()));
                                                              });
                                                    });
                                              },
                                              label: Text(
                                                'Reject',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          )
                        ],
                      ),
                    ),
                  ) : null;
                }),
          );
        }),
      ),
    );
  }

  Future<void> clearFeilds() async {
    await Get.find<SfaTourPlanController>().getSfaAllTourPlan(
        type: 'subordinates',
        start: MyDateUtils.getNepaliDateOnly(
          NepaliDateTime.now(),
        ),
        end: MyDateUtils.getNepaliDateOnly(NepaliDateTime.now()));
    await Get.find<SfaProductListController>().updateDate(null, null);
    type = 'subordinates';
    date = null;
    subOrdinateId = null;
    setState(() {});
  }

  void advanceFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: (context, setState) =>
                GetBuilder<SfaProductListController>(builder: (pcontroller) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 3.2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        DateRangeButton(
                          isNepaliDate: true,
                          nepaliDateFrom: startFrom,
                          nepaliDateTo: endTo,
                          width: 1.05,
                          label: "From Date     -      To Date",
                          onTap: () async {
                            date = await showMaterialDateRangePicker(
                              context: context,
                              firstDate: NepaliDateTime(1970),
                              lastDate: NepaliDateTime(2250),
                            );
                            if (date != null) {
                              setState(() {
                                startFrom = date!.start;
                                endTo = date!.end;
                              });
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
                              await Get.find<SfaTourPlanController>()
                                  .getSfaAllTourPlan(
                                      type: type,
                                      start: MyDateUtils.getNepaliDateOnly(
                                          date?.start),
                                      end: MyDateUtils.getNepaliDateOnly(
                                          date?.end),
                                      employeeId: subOrdinateId);
                              subOrdinateId = null;
                              employeeFilterName?.clear();
                              Get.back();
                            },
                            label: 'Filter')
                      ],
                    ),
                  );
                })));
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
                  title: Text(controller.subOrdinates?[index].name ?? ''),
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
