import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/attendanceController.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/core/constants/attendanceViewMode.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/views/attendenceReport/calenderAttendence.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendenceReportView extends StatefulWidget {
  const AttendenceReportView({super.key});

  @override
  State<AttendenceReportView> createState() => _AttendenceReportViewState();
}

class _AttendenceReportViewState extends State<AttendenceReportView> {
  NepaliDateTime? startDate;
  NepaliDateTime? endDate;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Get.find<AttendanceController>().getAttendance();
    // });
    Get.find<AttendanceController>().getAttendance(subOrdinateId);
    employeeFilterName = TextEditingController();
    Get.find<SfaProductListController>().getSubOrdinates();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(builder: (controller) {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Pallete.primaryCol,
          elevation: 0,
          leading: Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
              ),
            );
          }),
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Attendance",
                  style: TextStyle(
                    fontSize: 17.0,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.fromDate.value != null
                      ? Text(
                          MyDateUtils.getNepaliDateOnly(
                              controller.fromDate.value),
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        )
                      : Text('From Date'),
                  Text('  -  '),
                  controller.toDate.value != null
                      ? Text(
                          MyDateUtils.getNepaliDateOnly(
                              controller.toDate.value),
                          style: TextStyle(
                              fontSize: 13.0, fontWeight: FontWeight.bold),
                        )
                      : Text('To Date'),
                ],
              )
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  _modalBottomSheet(controller);
                },
                icon: Icon(
                  Icons.filter_alt,
                  size: 30,
                ))
          ],
        ),
        body: GetX<AttendanceController>(builder: (attendanceController) {
          if (attendanceController.attendenceViewMode.value ==
              AttendanceViewMode.LIST) {
            final refreshController = RefreshController();
            return Column(
              children: [
                Expanded(
                  child: SmartRefresher(
                    controller: refreshController,
                    onRefresh: () async {
                      await Get.find<AttendanceController>()
                          .refreshAttendance(subOrdinateId);
                      refreshController.refreshCompleted();
                    },
                    child: GetBuilder<AttendanceController>(
                      builder: (attendanceController) {
                        if (attendanceController.isLoading.value ||
                            attendanceController.isLoadg) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (attendanceController.attendances.isEmpty) {
                          return NoDataWidget();
                        }
                        return SingleChildScrollView(
                          child: ListView.builder(
                            itemCount: attendanceController.attendances.length,
                            shrinkWrap: true,
                            primary: false,
                            itemBuilder: (context, index) {
                              return AttendanceCard(
                                attendance:
                                    attendanceController.attendances[index],
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                height: context.height * 0.60,
                child: CalenderAttendence(),
              ),
            );
          }
        }),
      );
    });
  }

  _modalBottomSheet(AttendanceController controller) {
    TextEditingController dateController = TextEditingController();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
        builder: (builder) {
          return GetBuilder<SfaProductListController>(
              builder: (pController) => SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.close))),
                            SizedBox(
                              height: 12,
                            ),
                            GestureDetector(
                              onTap: () async {
                                NepaliDateTimeRange? date =
                                    await showMaterialDateRangePicker(
                                  context: context,
                                  firstDate: NepaliDateTime(1970),
                                  lastDate: NepaliDateTime(2250),
                                );
                                if (date != null) {
                                  dateController.value = TextEditingValue(
                                      text:
                                          '${MyDateUtils.getNepaliDateOnly(date.start)}  -  ${MyDateUtils.getNepaliDateOnly(date.end)}');
                                  controller.setFromPEDate(date.start);
                                  controller.setToPEDate(date.end);
                                }
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  controller: dateController,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      fillColor: Colors.indigo.shade50,
                                      filled: true,
                                      hintText: 'Select Date Range'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            TextField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              controller: employeeFilterName,
                              decoration: InputDecoration(
                                  labelText: 'Choose Subordinate'),
                              onTap: () {
                                showSubOrdinate(context, pController);
                              },
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                controller.handlePEFilter(subOrdinateId);
                                employeeFilterName?.clear();
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                  minimumSize:
                                      WidgetStateProperty.all(Size(340, 45))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.update),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'Filter',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ]),
                    ),
                  ));
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
            height: MediaQuery.of(context).size.height / 2,
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
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          );
        });
  }
}
