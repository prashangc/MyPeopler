import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/sfaCustomerListController.dart';
import 'package:my_peopler/src/controllers/sfaTourPlanController.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/sfa/sfa_beat_options.dart';
import 'package:my_peopler/src/models/sfa/sfa_tour_plan_model.dart';
import 'package:my_peopler/src/resources/color_manager.dart';
import 'package:my_peopler/src/widgets/no_data_widget.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';


class CreateTourPlan extends StatefulWidget {
  const CreateTourPlan({super.key});

  @override
  State<CreateTourPlan> createState() => _CreateTourPlanState();
}

class _CreateTourPlanState extends State<CreateTourPlan> {
  NepaliDateTime? startDate;
  NepaliDateTime? endDate;
  TextEditingController? nameController = TextEditingController();
  TextEditingController? detailController = TextEditingController();
  List<BeatOptionsModel>? _unchangableBeatOptionList;
  List<BeatOptionsModel> addedBeatOptions = [];
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _unchangableBeatOptionList =
          await Get.find<SfaCustomerListController>().getBeatOptions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Tour Plan'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTFF(
              hintText: 'Name',
              labelText: 'Name',
              controller: nameController,
            ),
            CustomTFF(
              hPad: 16,
              vPad: 0,
              maxLines: 7,
              radius: 12,
              labelText: "Detail",
              hintText: "Enter Detail",
              floatLabel: true,
              isLast: true,
              controller: detailController,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return "Enter Detail";
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DateRangeButton(
                  isNepaliDate: true,
                  nepaliDateFrom: startDate,
                  nepaliDateTo: endDate,
                    width: 1.1,
                    label: "From Date     -      To Date",
                    onTap: () async {
                  NepaliDateTimeRange? date = await showMaterialDateRangePicker(
                  context: context,
                  firstDate: NepaliDateTime(1970),
                  lastDate: NepaliDateTime(2250),
                );
                if (date != null) {
                  setStartDate(date.start);
                  setEndDate(date.end);
                }
                    },
                  ),
                ],
              ),
            ),
            addedBeatOptions.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorManager.creamColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                            children: List.generate(
                                addedBeatOptions.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: ColorManager.creamColor2,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        width: 400,
                                        child: ListTile(
                                            isThreeLine: false,
                                            title: Text(addedBeatOptions[index]
                                                .name
                                                .toString()),
                                            trailing: InkWell(
                                              onTap: () {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        '${addedBeatOptions[index].name} removed',
                                                    backgroundColor:
                                                        Colors.red);
                                                setState(() {
                                                  addedBeatOptions
                                                      .removeAt(index);
                                                });
                                              },
                                              child: Icon(Icons.close),
                                            )),
                                      ),
                                    ))),
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(
                          'No Beats Added',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                  ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton.icon(
                  onPressed: () {
                    Get.find<SfaCustomerListController>()
                        .searchBeat(_unchangableBeatOptionList);
                    showBeats();
                  },
                  icon: SizedBox(
                    height: 25,
                    width: 25,
                    child: CircleAvatar(
                        backgroundColor: ColorManager.white,
                        child: Icon(
                          Icons.add_outlined,
                          color: ColorManager.primaryCol,
                        )),
                  ),
                  label: Text(
                    'Add Beats',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ButtonStyle(
                      elevation: WidgetStateProperty.all(2),
                      shape: WidgetStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                      backgroundColor:
                          WidgetStateProperty.all(ColorManager.primaryCol)),
                ),
              ),
            ),
            GetBuilder<SfaTourPlanController>(builder: (controller) {
              return SubmitButton(
                hPad: 18,
                vPad: 0,
                onPressed: () async {
                  if (startDate == null || endDate == null) {
                    MessageHelper.showWarningAlert(
                        context: context,
                        title: 'Invalid Date',
                        desc: 'Please choose from and to date.',
                        btnOkOnPress: () {},
                        okBtnText: 'Ok');
                  } else {
                    var data = await controller.postSfaProductList(
                      SfaTourPlan(
                          title: nameController?.text,
                          description: detailController?.text,
                          startFrom:
                              '${startDate?.year}-${startDate?.month}-${startDate?.day}',
                          endTo:
                              '${endDate?.year}-${endDate?.month}-${endDate?.day}',
                          beats: addedBeatOptions
                              .map((e) => Beat(id: e.id))
                              .toList()),
                    );
                    MessageHelper.showInfoAlert(
                        context: context,
                        title: data,
                        btnOkOnPress: () {
                          controller.getSfaTourPlan();
                          Get.back();
                        },
                        okBtnText: 'Ok');
                  }
                },
                label: "Submit",
                isLoading: controller.isLoading,
              );
            })
          ],
        ),
      ),
    );
  }

  Future<void> showBeats() {
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
                                        addBeatsMethod(e);
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

  void addBeatsMethod(BeatOptionsModel e) {
     if (addedBeatOptions.isEmpty) {
      addedBeatOptions.add(BeatOptionsModel(
          id: e.id, name: e.name));
      Fluttertoast.showToast(
          msg: '${e.name} added',
          backgroundColor: Colors.green);
    } else {
      bool isDuplicate = false;
      for (var i = 0;
          i < addedBeatOptions.length;
          i++) {
        if (e.id !=
            addedBeatOptions[i].id) {
          isDuplicate = false;
        } else if (e.id ==
            addedBeatOptions[i].id) {
          isDuplicate = true;
          Fluttertoast.showToast(
              msg:
                  '${e.name} is already added',
              backgroundColor: Colors.red);
          break;
        }
      }
    
      if (isDuplicate == false) {
        addedBeatOptions.add(
            BeatOptionsModel(
                id: e.id, name: e.name));
        Fluttertoast.showToast(
            msg: '${e.name} added',
            backgroundColor: Colors.green);
      }
    }
    
    Get.back();
    setState(() {});
  }

  setStartDate(NepaliDateTime val) {
    setState(() {
      startDate = val;
    });
  }

  setEndDate(NepaliDateTime val) {
    setState(() {
      endDate = val;
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
}
