import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/location_tracking_controller.dart';
import 'package:my_peopler/src/controllers/sfaProductListController.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationTrack extends StatefulWidget {
  const LocationTrack({super.key});

  @override
  State<LocationTrack> createState() => _LocationTrackState();
}

class _LocationTrackState extends State<LocationTrack> {
  WebViewController? _controller;
  NepaliDateTime selectedDate = NepaliDateTime.now();
  late NepaliDateTime date = selectedDate;
  TextEditingController? employeeFilterName;
  int? subOrdinateId;
  final expenseDate =
      Get.arguments?[0] ?? MyDateUtils.getNepaliDateOnly(NepaliDateTime.now());
  final expenseSubordinateId = Get.arguments?[1];

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
  void initState() {
    employeeFilterName = TextEditingController();
    Get.find<SfaProductListController>().getSubOrdinates();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    var controller = Get.find<LocationTrackController>();
    controller.getSfaLocationTrack(expenseDate, expenseSubordinateId);
    super.initState();
  }

  void buildSetState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Tracking'),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon((Icons.filter_list)),
                onPressed: () async {
                  var controller = Get.find<LocationTrackController>();
                  _modalBottomSheet(controller, buildSetState);
                },
              ))
        ],
      ),
      body: GetBuilder<LocationTrackController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.response == null) {
            return NoDataWidget();
          } else {
            _controller!.loadHtmlString(controller.response!);
            return WebViewWidget(controller: _controller!);
          }
        },
      ),
    );
  }

  _modalBottomSheet(
      LocationTrackController controller, Function buildSetState) {
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
                                  controller.getSfaLocationTrack(
                                      MyDateUtils.getNepaliDateOnly(date),
                                      subOrdinateId,
                                      buildSetState);
                                  employeeFilterName?.clear();
                                  subOrdinateId = null;
                                  Navigator.of(context).pop();
                                },
                                style: ButtonStyle(
                                    minimumSize:
                                        WidgetStateProperty.all(Size(250, 50))),
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
