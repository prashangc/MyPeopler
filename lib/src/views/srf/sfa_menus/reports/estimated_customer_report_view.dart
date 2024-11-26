import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/estimatedCustomerReportController.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class EstimatedCustomerReportView extends StatefulWidget {
  const EstimatedCustomerReportView({super.key});

  @override
  State<EstimatedCustomerReportView> createState() =>
      _EstimatedCustomerReportViewState();
}

class _EstimatedCustomerReportViewState
    extends State<EstimatedCustomerReportView> {
  NepaliDateTime selectedDate = NepaliDateTime.now();
  late NepaliDateTime date = selectedDate;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  @override
  void initState() {
    employeeFilterName = TextEditingController();
    Get.find<SfaProductListController>().getSubOrdinates();
    var controller = Get.find<EstimatedCustomerReportController>();
    controller.getSfaEstimatedCustomerReport(NepaliDateTime.now(), null);
    super.initState();
  }

  Future<NepaliDateTime?> _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final NepaliDateTime? picked = await showMaterialDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: NepaliDateTime(2014),
        lastDate: NepaliDateTime(2101));
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      var pickedDate = picked.toString().split(" ")[0];
      dateController.value = TextEditingValue(text: pickedDate);
      return picked;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estimated Customer Report'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon((Icons.filter_list)),
                onPressed: () async {
                  var controller =
                      Get.find<EstimatedCustomerReportController>();
                  _modalBottomSheet(controller);
                },
              ))
        ],
      ),
      body: GetBuilder<EstimatedCustomerReportController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.sfaCustomerReport.isEmpty) {
            return NoDataWidget();
          }
          return Column(
            children: [
              _tableRow(context),
              listViewBuilder(context, controller)
            ],
          );
        },
      ),
    );
  }

  // void buildSetState() {
  //   setState(() {});
  // }

  _modalBottomSheet(
      EstimatedCustomerReportController controller) {
    TextEditingController dateController =
        TextEditingController(text: 'Select Date');
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        builder: (builder) {
          return GetBuilder<SfaProductListController>(
            builder: (pController) {
              return DraggableScrollableSheet(
                  snap: true,
                  initialChildSize: 1,
                  builder: (context, scrollController) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                date = await _selectDate(
                                        context, dateController) ??
                                    selectedDate;
                              },
                              child: AbsorbPointer(
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: dateController,
                                ),
                              ),
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
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.getSfaEstimatedCustomerReport(
                                      date, subOrdinateId);
                                  employeeFilterName?.clear();
                                  subOrdinateId = null;
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                    minimumSize: WidgetStateProperty.all(
                                        Size(250, 50))),
                                child: Text(
                                  'Filter',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            )
                          ]),
                    );
                  });
            },
          );
        });
  }

  listViewBuilder(BuildContext context, EstimatedCustomerReportController controller) {
    return SizedBox(
      height: MediaQuery.of(context).size.height/1.25,
      child: ListView.builder(
                itemBuilder: (context, index) {
                  var customerName = controller.sfaCustomerReport[index].name;
                  var customerStatus =
                      controller.sfaCustomerReport[index].customerStatus;
                  var orderAmount = controller.sfaCustomerReport[index].orderAmount ?? 0;
                  return Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: index.isOdd ? ColorManager.creamColor : ColorManager.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: SizedBox(
                            width:  MediaQuery.of(context).size.width / 2,
                            child: Text(customerName),
                          ),
                        ),
                        SizedBox(
                          width:  MediaQuery.of(context).size.width / 5,
                          child: Text(orderAmount.toString()),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child:  customerStatus == "in_id_no_order"
                            ? Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 18,
                              )
                            : customerStatus == "not_in_id_but_order"?
                            Icon(
                                Icons.bookmark_border,
                                color: Colors.orange,
                              ):
                             Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: controller.sfaCustomerReport.length),
    );
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

  _tableRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: Container(
        color: ColorManager.orangeColor,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: Text(
                    'Customer'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  child: Text(
                    'Order Amount'.toUpperCase(),textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
              Text(
                    'Status'.toUpperCase(),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
            ],
          ),
        ),
      ),
    );
  }
}
