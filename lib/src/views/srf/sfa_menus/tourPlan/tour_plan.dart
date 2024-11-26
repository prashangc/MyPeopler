import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TourPlan extends StatefulWidget {
  const TourPlan({super.key});

  @override
  State<TourPlan> createState() => _TourPlanState();
}

class _TourPlanState extends State<TourPlan> {
  RefreshController refreshcontroller = RefreshController();
  final RefreshController _refreshcontroller = RefreshController();
  NepaliDateTimeRange? date;
  NepaliDateTime? startFrom;
  NepaliDateTime? endTo;
  bool tourPlanReport = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<SfaTourPlanController>().getSfaTourPlan();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshcontroller,
      onRefresh: () {
        Get.find<SfaTourPlanController>().getSfaTourPlan();
        _refreshcontroller.refreshCompleted();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tour Plan'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                  onPressed: () {
                    showDateFilter();
                  },
                  icon: Icon(
                    Icons.filter_alt,
                    size: 28,
                  )),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Create Tour Plan',
          backgroundColor: ColorManager.primaryColorLight,
          onPressed: () {
            Get.toNamed(Routes.CREATE_TOUR_PLAN);
          },
          child: Icon(
            Icons.add,
          ),
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
              Get.find<SfaTourPlanController>().getSfaTourPlan();
              refreshcontroller.refreshCompleted();
            },
            child: ListView.builder(
                itemCount: controller.sfaTourPlans.length,
                itemBuilder: (context, index) {
                  var startDate =
                      controller.sfaTourPlans[index].startFrom ?? 'N/A';
                  var status =
                      controller.sfaTourPlans[index].status ?? 'pending';
                  var endDate = controller.sfaTourPlans[index].endTo ?? 'N/A';
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.TOUR_PLAN_DETAIL_VIEW,
                          arguments: [controller.sfaTourPlans[index], false, tourPlanReport]);
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
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          controller
                                                  .sfaTourPlans[index].title ??
                                              "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.zero,
                                            width: 70,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: status == 'approved'
                                                  ? Colors.green
                                                  : status == 'pending'
                                                      ? Colors.orange
                                                      : status == 'completed'
                                                          ? const Color(
                                                              0xffd3af37)
                                                          : Colors.red,
                                            ),
                                            child: Center(
                                                child: Text(
                                              controller.sfaTourPlans[index]
                                                      .status ??
                                                  '',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ))),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    controller
                                            .sfaTourPlans[index].description ??
                                        "",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                    textAlign: TextAlign.justify,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'From: $startDate',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                      Text(
                                        'To: $endDate',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Tour Day: ${controller.sfaTourPlans[index].tourDays ?? 0}',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  )
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
                  );
                }),
          );
        }),
      ),
    );
  }

  showDateFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) => StatefulBuilder(
              builder: (context, setState) =>
                  GetBuilder<SfaTourPlanController>(builder: (controller) {
                return SizedBox(
                    height: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  fixedSize: WidgetStatePropertyAll(
                                      Size(double.maxFinite, 60))),
                              onPressed: () {
                                controller.getSfaTourPlan(
                                    start: date?.start, end: date?.end);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Filter',
                                style: TextStyle(fontSize: 18),
                              )),
                        )
                      ],
                    ));
              }),
            ));
  }
}
