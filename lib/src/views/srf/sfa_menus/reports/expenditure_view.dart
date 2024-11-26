import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/attendanceController.dart';
import 'package:my_peopler/src/controllers/expenseController.dart';
import 'package:my_peopler/src/controllers/profileController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/attendance/attendancesResponse.dart';
import 'package:my_peopler/src/models/expenses/expense_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
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

class ExpenditureView extends StatefulWidget {
  const ExpenditureView({super.key});

  @override
  State<ExpenditureView> createState() => _ExpenditureViewState();
}

class _ExpenditureViewState extends State<ExpenditureView> {
  final refreshController = RefreshController();
  NepaliDateTimeRange? date;
  int? subOrdinateId;
  String status = '';

  TextEditingController? employeeFilterName;
  @override
  void initState() {
    employeeFilterName = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Get.find<ExpenseController>().getExpenses(type: 'subordinates');
      await Get.find<SfaProductListController>().getSubOrdinates();
      Get.find<ProfileController>().getProfile();
      type = 'subordinates';
      setState(() {});
    });
    super.initState();
  }

  int? getUserId() {
    var controller = Get.put(ProfileController());
    return controller.user?.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(
                'Expenditure - ${type.toUpperCase()}',
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
                    await Get.find<ExpenseController>()
                        .getExpenses(type: 'subordinates');
                    type = 'subordinates';
                    setState(() {});
                    break;
                  case own:
                    date = null;
                    await Get.find<ExpenseController>()
                        .getExpenses(type: 'own');
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
        body: GetBuilder<ExpenseController>(builder: (controller) {
          return GetBuilder<AttendanceController>(
              builder: (attendanceController) {
                
            var attendances = attendanceController.expenseAttendance;

            if (controller.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if ((controller.response?.data ?? {}).isEmpty) {
              return SmartRefresher(
                  controller: refreshController,
                  onRefresh: () async {
                    subOrdinateId = null;
                    type = 'subordinates';
                    await Get.find<ExpenseController>()
                        .getExpenses(type: 'subordinates');
                    await Get.find<ExpenseController>().getExpenseCategories();
                    await Get.find<AttendanceController>()
                        .getExpenseAttendance(null, null, null);
                    refreshController.refreshCompleted();
                  },
                  child: NoDataWidget());
            }

          var response = controller.response!;
          var responseData = response.data;
          var expenseKeys = controller.expenseKeys;

            return SmartRefresher(
                controller: refreshController,
                onRefresh: () async {
                  setState(() {
                    subOrdinateId = null;
                  });
                  type = 'subordinates';
                  date = null;
                  await Get.find<ExpenseController>()
                      .getExpenses(type: 'subordinates');
                  await Get.find<ExpenseController>().getExpenseCategories();
                  refreshController.refreshCompleted();
                },
                child: ListView.separated(shrinkWrap: true, 
                itemBuilder: (context, index) {
                    var date = expenseKeys[index];
                    var employeeKeys = response.getAllExpenseKeysForDate(date);
                    var dateResponse = responseData[date]!;
                    var dateAttendances = attendances
                          .where((e) =>
                              MyDateUtils.getNepaliDateOnly(
                                  e.details.first.attendance_date) ==
                              date)
                          .toList();
                    return buildListWidget(date, employeeKeys, dateResponse, dateAttendances, controller, index);
                }, separatorBuilder: (context, index) => SizedBox(
                          height: 0,
                        ), itemCount: expenseKeys.length));
          });
        }));
  }

  Widget buildListWidget(String expenseDate, List<String> keys, Map<String, List<Expense>> expenseData, 
  List<Attendance> attendance, ExpenseController controller, int dateIndex) {
                    return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var employeeId = keys[index];
                      var expenses = expenseData[employeeId] ?? [];
                      var employeeIntId = int.parse(employeeId);
                      if (expenses.any((element) => element.status == 'pending')) {
                        status = 'pending';
                      } else if (expenses.every((e) => e.status == 'approved')) {
                        status = 'approved';
                      } else if (expenses.every((e) => e.status == 'rejected')) {
                        status = 'rejected';
                      } else {
                        status = 'completed';
                      }
                      var totalAskingExpense = expenses.fold(
                          0,
                          ((previousValue, element) =>
                              previousValue + int.parse(element.askingAmount)));
                      var totalApprovedExpense =
                          expenses.fold(0, ((previousValue, element) {
                        int approvedAmount = element.approvedAmount ?? 0;
                        return previousValue + approvedAmount;
                      }));
                      return GetBuilder<SfaProductListController>(
                          builder: (pcontroller) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.EXPENSES_VIEW, arguments: [
                              expenseDate,
                              pcontroller.startDate,
                              pcontroller.endDate,
                              employeeIntId,
                              true,
                              dateIndex,
                              employeeId
                            ]);
                          },
                          child: Container(
                            height:  220,
                            padding: EdgeInsets.only(top: 0, left: 8, right: 8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              employeeIntId != getUserId()? status == 'pending'
                                    ? viewTourRoute(expenseDate, int.tryParse(employeeId))
                                    : SizedBox(
                                        height: 10,
                                      ): SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month_sharp,
                                      color: Colors.blue,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      expenseDate,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ColorManager.primaryCol),
                                    ),
                                    Spacer(),
                                    Container(
                                        height: 20,
                                        width: 70,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: status == 'pending'
                                                ? Colors.orange
                                                : status == 'approved'
                                                    ? Colors.green
                                                    : status == 'rejected'
                                                        ? Colors.red
                                                        : const Color.fromARGB(
                                                    255, 200, 156, 24)),
                                        child: Center(
                                            child: Text(
                                          status,
                                          style: TextStyle(color: Colors.white),
                                        )))
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'Total Asking Amount:  Rs.${totalAskingExpense.toString()}'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    'Total Approved Amount:  Rs.${totalApprovedExpense.toString()}'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Employee: ${expenses.first.employeeName}'),
                                 SizedBox(
                                  height: 5,
                                ),
                                attendance.isNotEmpty
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                            Text(
                                                'Check In: ${MyDateUtils.getTimeOnly(attendance.first.details.first.attendance_date?.toLocal())}'),
                                            Text(
                                                'Check Out: ${attendance.first.details.last.state == 1 ? MyDateUtils.getTimeOnly(attendance.first.details.last.attendance_date!.toLocal()) : "N/A"}'),
                                          ])
                                    : SizedBox.shrink(),
                              employeeIntId != getUserId()? status == 'pending'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TextButton.icon(
                                                  icon: Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.green),
                                                      fixedSize:
                                                          WidgetStatePropertyAll(
                                                              Size(120, 20)),
                                                      shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)))),
                                                  onPressed: () {
                                                    callStatus(
                                                        context,
                                                        'approve',
                                                        expenses,
                                                        controller,
                                                        pcontroller.startDate ?? NepaliDateTime.now(),
                                                        pcontroller.endDate ?? NepaliDateTime.now(),
                                                        subOrdinateId);
                                                  },
                                                  label: Text(
                                                    'Approve',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.5),
                                                  )),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              TextButton.icon(
                                                  icon: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStatePropertyAll(
                                                              Colors.red),
                                                      fixedSize:
                                                          WidgetStatePropertyAll(
                                                              Size(120, 20)),
                                                      shape: WidgetStatePropertyAll(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)))),
                                                  onPressed: () {
                                                    callStatus(
                                                        context,
                                                        'reject',
                                                        expenses,
                                                        controller,
                                                        pcontroller.startDate ?? NepaliDateTime.now(),
                                                        pcontroller.endDate ?? NepaliDateTime.now(),
                                                        subOrdinateId);
                                                  },
                                                  label: Text(
                                                    'Reject',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 11.5),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )
                                    : viewTourRoute(expenseDate, int.tryParse(employeeId))
                                    : SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        );
                      });
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 0,
                        ),
                    itemCount: keys.length);
  }

  Future<void> clearFeilds() async {
    await Get.find<ExpenseController>().getExpenses(type: 'subordinates');
    await Get.find<SfaProductListController>().updateDate(null, null);
    type = 'subordinates';
    date = null;
    subOrdinateId = null;
    setState(() {});
  }

  search(String searchTerm) {
    // List<SfaPaymentList>? result = _unchangableSfaPaymentList.where((products) {
    //   String name = products.employeeName?.toLowerCase() ?? 'N/A';
    //   String customerName = products.customerName!.toLowerCase();
    //   String clientType = products.method!.toLowerCase();
    //   String orderNumber =
    //       products.refNo == null ? '' : products.refNo!.toLowerCase();
    //   final searchItem = searchTerm.toLowerCase();
    //   return name.contains(searchItem) ||
    //       customerName.contains(searchItem) ||
    //       clientType.contains(searchItem) ||
    //       orderNumber.contains(searchItem);
    // }).toList();
    // Get.find<SfaPaymentCollectionController>().searchPaymentReports(result);
  }

  void advanceFilter() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<SfaProductListController>(builder: (pcontroller) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3.2,
              child: Column(
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
                        await Get.find<ExpenseController>().getExpenses(
                            type: type,
                            start: date?.start,
                            end: date?.end,
                            employeeId: subOrdinateId);
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

  Widget viewTourRoute(String date, int? employeeId) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextButton.icon(
            icon: Icon(
              Icons.tour,
              color: Colors.white,
              size: 20,
            ),
            style: ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(ColorManager.lightPurple2),
                fixedSize: WidgetStatePropertyAll(Size(120, 20)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
            onPressed: () {
              Get.find<SfaTourPlanController>().getSfaAllTourPlan(
                  type: 'subordinates',
                  start: date,
                  end: date,
                  employeeId: employeeId);
              showTourDetail(context);
            },
            label: Text(
              'Tour Plan',
              style: TextStyle(color: Colors.white, fontSize: 11.5),
            )),
        SizedBox(
          width: 20,
        ),
        TextButton.icon(
            icon: Icon(
              Icons.location_on,
              color: Colors.white,
              size: 20,
            ),
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    const Color.fromARGB(255, 165, 206, 118)),
                fixedSize: WidgetStatePropertyAll(Size(120, 20)),
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
            onPressed: () {
              Get.toNamed(Routes.LOCATION_LOG, arguments: [date, employeeId]);
            },
            label: Text(
              'View Route',
              style: TextStyle(color: Colors.white, fontSize: 11.5),
            )),
      ],
    );
  }

  Future<void> showTourDetail(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height - 40,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child:
                      GetBuilder<SfaTourPlanController>(builder: (controller) {
                    var tourPlanList = controller.sfaTourPlans.length;
                    var startDate = controller.sfaTourPlans.isNotEmpty
                        ? controller.sfaTourPlans.first.startFrom
                        : '';
                    var endDate = controller.sfaTourPlans.isNotEmpty
                        ? controller.sfaTourPlans.first.endTo
                        : '';
                    if (controller.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (controller.sfaTourPlans.isEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                size: 30,
                              )),
                          NoDataWidget(
                            title: 'No Tour Plan Added.',
                          ),
                        ],
                      );
                    }
                    return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: (tourPlanList > 1)
                              ? ListView.separated(
                                shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    var listStartDate = controller
                                        .sfaTourPlans[index].startFrom;
                                    var listEndDate =
                                        controller.sfaTourPlans[index].endTo;
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            Routes.TOUR_PLAN_DETAIL_VIEW,
                                            arguments: [
                                              controller.sfaTourPlans[index],
                                              false,false
                                            ]);
                                      },
                                      child: Card(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      controller
                                                              .sfaTourPlans[
                                                                  index]
                                                              .title ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      controller
                                                              .sfaTourPlans[
                                                                  index]
                                                              .description ??
                                                          "",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'From: $listStartDate',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                        Text(
                                                          'To: $listEndDate',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      'Tour Day: ${controller.sfaTourPlans[index].tourDays}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
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
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 20,
                                      ),
                                  itemCount: controller.sfaTourPlans.length)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('From: $startDate'),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(Icons.close))
                                      ],
                                    ),
                                    Text('To: $endDate'),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                        child: Text(
                                      'Tour Plan Details',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'Title: ${controller.sfaTourPlans.first.title ?? ''}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Description: ${controller.sfaTourPlans.first.description ?? ''}',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Center(
                                        child: Text(
                                      'Beats',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                    controller.sfaTourPlans.first.beats!
                                            .isNotEmpty
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ...List.generate(
                                                controller.sfaTourPlans.first
                                                    .beats!.length,
                                                (index) => Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 2,
                                                    right: 2,
                                                    top: 16,
                                                  ),
                                                  child: ListTile(
                                                    shape:
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                    tileColor: ColorManager
                                                        .creamColor2,
                                                    title: Text(controller
                                                            .sfaTourPlans
                                                            .first
                                                            .beats?[index]
                                                            .name ??
                                                        ''),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        : SizedBox(
                                            height: 80,
                                            child: Center(
                                                child: Text('No Beats Added',
                                                    style: TextStyle(
                                                        fontSize: 20))))
                                  ],
                                )),
                    );
                  }),
                ),
              ]),
        ));
      },
    );
  }

  callStatus(
      BuildContext context,
      String value,
      List<Expense> expenses,
      ExpenseController controller,
      NepaliDateTime startDate,
      NepaliDateTime endDate,
      int? subOrdinate) {
    List<Expense> expenseList = [];

    for (Expense expense in expenses) {
      if (expense.status == 'pending') {
        expenseList.add(expense);
      }
    }
    if (value == 'approve') {
      MessageHelper.showInfoAlert(
          context: context,
          title: 'Approve All',
          desc: 'Are you sure?',
          okBtnText: 'Yes',
          cancelBtnText: 'No',
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            var message = await controller.changeBulkStatus(
              expenses: expenseList,
              status: 'approved',
            );
            if (!context.mounted) return;
            MessageHelper.showInfoAlert(
                context: context,
                title: message,
                okBtnText: 'Ok',
                btnOkOnPress: () {
                  controller.getExpenses(
                      employeeId: subOrdinate,
                      type: 'subordinates',
                      start: startDate,
                      end: endDate);
                });
          });
    } else {
      MessageHelper.showInfoAlert(
          context: context,
          title: 'Reject All',
          desc: 'Are you sure?',
          okBtnText: 'Yes',
          cancelBtnText: 'No',
          btnCancelOnPress: () {},
          btnOkOnPress: () async {
            var message = await controller.changeBulkStatus(
              expenses: expenseList,
              status: 'rejected',
            );
            if (!context.mounted) return;
            MessageHelper.showInfoAlert(
                context: context,
                title: message,
                okBtnText: 'Ok',
                btnOkOnPress: () {
                  controller.getExpenses(
                      employeeId: subOrdinate,
                      type: 'subordinates',
                      start: startDate,
                      end: endDate);
                });
          });
    }
  }
}
