import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:my_peopler/src/widgets/widgets.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class NewLeaveRequestView extends StatefulWidget {
  const NewLeaveRequestView({Key? key}) : super(key: key);

  @override
  State<NewLeaveRequestView> createState() => _NewLeaveRequestViewState();
}

class _NewLeaveRequestViewState extends State<NewLeaveRequestView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reason = TextEditingController();
  String catId = "1";

  NepaliDateTime? startDate;
  NepaliDateTime? endDate;

  TimeOfDay? fromtime;
  TimeOfDay? totime;

  setCatId(String val) {
    setState(() {
      catId = val;
    });
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

  setFromTime(TimeOfDay time){
    setState(() {
      fromtime = time;
    });
  }

  setToTime(TimeOfDay time){
    setState(() {
      totime = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.find<NavController>().back();
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text("Leave Request"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomTFF(
              //   hPad: 0,
              //   vPad: 5,
              //   maxLines: 1,
              //   radius: 12,
              //   labelText: "Leave Title",
              //   floatLabel: true,
              // ),
              GetBuilder<LeaveController>(builder: (leaveController) {
                return CustomDFF(
                  name: "Leave Category",
                  items: [
                    ...leaveController.leaveCategory.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e.id.toString(),
                          child: Text(e.leave_category??""),
                        );
                      },
                    )
                  ],
                  onChanged: (val) {
                    if(val == null){
                      return;
                    }
                    catId = val;
                  },
                  value: null,
                  hideLabel: true,
                );
              }),
              CustomTFF(
                hPad: 0,
                vPad: 0,
                maxLines: 3,
                radius: 12,
                labelText: "Reason",
                floatLabel: true,
                isLast: true,
                controller: _reason,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter reason";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              SizedBox(height: 20,),
              TimeRangeButton(
                label: 'From Time     -      To Time',
                 width: 1.1,
                 timeFrom: fromtime,
                 timeTo: totime,
                   onTap: () async {
                    // 
                    TimeOfDay? toTime;

                    TimeOfDay? fromTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now(),
                      helpText: 'Select From Time'
                      );
                      
                    if(fromTime != null) {
                      if (context.mounted){
                         toTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now(),
                        helpText: 'Select To Time',
                        );
                      }
                    }

                    if(fromTime != null && toTime != null){
                       setFromTime(fromTime);
                       setToTime(toTime);
                    }
                  },
                ),
              GetBuilder<LeaveController>(builder: (controller) {
                return SubmitButton(
                  hPad: 0,
                  vPad: 30,
                  onPressed: () async {
                    if (controller.isRequestingForLeave.value) {
                      return;
                    }
                    if(fromtime !=null && totime!=null){
                      await _requestLeaveWithTime();
                    }else{
                      await _requestLeave();
                    }
                    
                  },
                  label: "Request",
                  isLoading: controller.isRequestingForLeave.value,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  _requestLeave() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Get.find<LeaveController>().requestLeave(
        reason: _reason.text,
        catId: catId,
        startDate: MyDateUtils.getleaveDateOnly(startDate!),
        endDate: endDate == null
            ? MyDateUtils.getleaveDateOnly(startDate!)
            : MyDateUtils.getleaveDateOnly(endDate!),
      );
    }
  }

  _requestLeaveWithTime() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      await Get.find<LeaveController>().requestLeave(
        reason: _reason.text,
        catId: catId,
        startDate:
            '${startDate!.year}-${startDate!.month}-${startDate!.day} ${fromtime?.hour}:${fromtime?.minute}:00',
        endDate: endDate == null
            ? '${startDate!.year}-${startDate!.month}-${startDate!.day} ${fromtime?.hour}:${fromtime?.minute}:00'
            : '${endDate!.year}-${endDate!.month}-${endDate!.day} ${totime?.hour}:${totime?.minute}:00',
      );
    }
  }
}
