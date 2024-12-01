// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_peopler/location_service_repo.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/controllers/sfalocationLogsController.dart';
import 'package:my_peopler/src/core/constants/secureStorageConstants.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/baseResponse.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user/user.dart';

class AttendenceStatus extends StatefulWidget {
  const AttendenceStatus({
    super.key,
  });

  @override
  State<AttendenceStatus> createState() => _AttendenceStatusState();
}

class _AttendenceStatusState extends State<AttendenceStatus> {
  bool showDialogBox = false;
  List<AttendanceBoundary> _attendanceBoundary = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.find<AttendanceController>().setFromPEDate(NepaliDateTime.now());
    Get.find<AttendanceController>().setToPEDate(NepaliDateTime.now());

    if (StorageHelper.attendanceBoundary.isNotEmpty) {
      if (StorageHelper.attendanceBoundary is List<AttendanceBoundary>) {
        _attendanceBoundary =
            StorageHelper.attendanceBoundary as List<AttendanceBoundary>;
      } else {
        _attendanceBoundary = List<AttendanceBoundary>.from(StorageHelper
            .attendanceBoundary
            .map((x) => AttendanceBoundary.fromJson(x)));
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String title(
      bool checkOut, bool beforeLunch, bool afterLunch, String timeDifference) {
    if (checkOut) {
      if (beforeLunch) {
        return 'You are Leaving $timeDifference before Lunch!';
      } else {
        return 'You are $timeDifference Early to Leave!';
      }
    } else {
      if (afterLunch) {
        return 'You are $timeDifference Late after Lunch!';
      } else {
        return 'You are $timeDifference Late!';
      }
    }
  }

  getTimeOutDetail(AttendanceController controller, BuildContext contextmain,
      Duration timeDiffer,
      {bool checkOut = false,
      bool beforeLunch = false,
      bool afterLunch = false}) {
    TextEditingController explainController = TextEditingController();
    String timeDifference =
        timeDiffer.toString().split('.').first.padLeft(8, "0");
    showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: _formKey,
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            insetPadding: EdgeInsets.symmetric(horizontal: 20),
            elevation: 2,
            title:
                Text(title(checkOut, beforeLunch, afterLunch, timeDifference)),
            content: TextFormField(
              controller: explainController,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              // validator: (value) {
              // return  value!.isEmpty ? 'Field is Required' : null;
              // },
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                  hintText: 'Please fill up explanation.'),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding: EdgeInsets.only(bottom: 30, right: 8, left: 8),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize:
                          WidgetStatePropertyAll(Size(double.maxFinite, 50))),
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    getAltitude(
                      controller,
                      contextmain,
                      isCheckIn: true,
                      details: [
                        explainController.text,
                        title(checkOut, beforeLunch, afterLunch, timeDifference)
                      ],
                    );
                    // }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 14),
                  ))
            ],
          ),
        );
      },
    );
  }

  getAltitude(
    AttendanceController controller,
    BuildContext context, {
    List<String?>? details,
    required bool isCheckIn,
  }) async {
    controller.freezeUI();
    Position locationData = await Geolocator.getCurrentPosition();
    double height = locationData.altitude * 3.28084;
    log(locationData.longitude.toString());
    log(locationData.latitude.toString());

    // double distanceBetween = await Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude)
    if (_attendanceBoundary.isNotEmpty) {
      for (var i = 0; i < _attendanceBoundary.length; i++) {
        double distance = Geolocator.distanceBetween(
            locationData.latitude,
            locationData.longitude,
            double.parse(_attendanceBoundary[i].latitude.toString()),
            double.parse(_attendanceBoundary[i].longitude.toString()));
        if (distance <=
                double.parse(_attendanceBoundary[i].radius.toString()) &&
            ((double.parse(_attendanceBoundary[i].elevation.toString()) - 1 <=
                    height) &&
                (double.parse(_attendanceBoundary[i].elevation.toString()) +
                        1 >=
                    height))) {
          await _punch(
            controller,
            context,
            details: details,
            isCheckIn: isCheckIn,
          );
          break;
        } else {
          if (i == _attendanceBoundary.length - 1) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (showDialogBox == true) {
                Get.back();
              }
            });
            MessageHelper.showInfoAlert(
                context: context,
                title: 'Invalid Location',
                desc: 'Go to correct location for your attendance.',
                btnOkOnPress: () {
                  showDialogBox = false;
                  controller.unfreezeUI();
                },
                okBtnText: 'Ok',
                cancelBtnText: 'Cancel',
                btnCancelOnPress: () {
                  showDialogBox = false;
                  controller.unfreezeUI();
                });
          }
        }
      }
    } else {
      await _punch(
        controller,
        context,
        details: details,
        isCheckIn: isCheckIn,
      );
    }
  }

  @override
  Widget build(BuildContext contextmain) {
    return Builder(builder: (context) {
      return GetBuilder<AttendanceController>(builder: (controller) {
        controller.isPunching == true
            ? WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialogBox = true;
                showDialog(
                    context: context,
                    builder: (context) {
                      return PopScope(
                          canPop: false,
                          onPopInvoked: (a) {
                            false;
                          },
                          child: Center(child: CircularProgressIndicator()));
                    },
                    barrierDismissible: false);
              })
            : WidgetsBinding.instance.addPostFrameCallback((_) {
                if (showDialogBox == true) {
                  Get.back();
                }
              });
        return GetBuilder<ProfileController>(builder: (profileController) {
          var shifts = profileController.user?.shifts ?? [];
          if (profileController.user == null) {
            return SizedBox.shrink();
          }
          if (profileController.user!.enable_attendance_from_mobile == 0) {
            return SizedBox.shrink();
          }

          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Column(
                children: [
                  Text(
                    "Total attendance Status",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      var prefs = await SharedPreferences.getInstance();
                      int? userId = prefs.getInt("userId");
                      if (userId != null) {
                        List<String> file = await LocationServiceRepository
                            .readLocationForUserId(userId);
                        MessageHelper.success("FILE LENGTH -> ${file.length}");
                      } else {
                        MessageHelper.error("USER ID IS NULL");
                      }
                    },
                    child: Text(
                      "Check if location tracking",
                    ),
                  ),

                  SizedBox(height: 20.0),

                  //  controller.isPunching == true
                  //     ? LinearProgressIndicator()
                  //     : SizedBox.shrink(),
                  SizedBox(
                    height: 10,
                  ),
                  StorageHelper.locationAccept!
                      ? SizedBox(
                          height: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: controller.attendances.isNotEmpty
                                    ? controller
                                            .attendances.last.details.isNotEmpty
                                        ? controller.attendances.last.details
                                                .length.isEven
                                            ? () async {
                                                MessageHelper.showInfoAlert(
                                                  context: context,
                                                  title: 'Checking In',
                                                  desc:
                                                      'Do you want to check in?',
                                                  okBtnText: 'Yes',
                                                  cancelBtnText: 'No',
                                                  btnCancelOnPress: () {
                                                    //Navigator.pop(context);
                                                  },
                                                  btnOkOnPress: () async {
                                                    if (shifts.isNotEmpty) {
                                                      String
                                                          lunchOutTimeString =
                                                          await readValue(
                                                              lunchOutTime);
                                                      var format = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(
                                                              DateTime.now());
                                                      DateTime endLunchTime =
                                                          DateTime.parse(
                                                              '$format $lunchOutTimeString');
                                                      var checkInAttendance =
                                                          DateTime.now()
                                                              .toLocal();
                                                      if (controller
                                                                  .attendances
                                                                  .last
                                                                  .details
                                                                  .length ==
                                                              2 &&
                                                          lunchOutTimeString !=
                                                              "00:00:01") {
                                                        if (checkInAttendance
                                                            .isAfter(endLunchTime
                                                                .toLocal())) {
                                                          var timeDifference2 =
                                                              checkInAttendance
                                                                  .difference(
                                                                      endLunchTime
                                                                          .toLocal());
                                                          getTimeOutDetail(
                                                              controller,
                                                              contextmain,
                                                              timeDifference2,
                                                              afterLunch: true);
                                                        } else {
                                                          await getAltitude(
                                                            controller,
                                                            contextmain,
                                                            isCheckIn: true,
                                                          );
                                                        }
                                                      } else {
                                                        await getAltitude(
                                                          controller,
                                                          contextmain,
                                                          isCheckIn: true,
                                                        );
                                                      }
                                                    } else {
                                                      await getAltitude(
                                                        controller,
                                                        contextmain,
                                                        isCheckIn: true,
                                                      );
                                                    }
                                                  },
                                                );
                                              }
                                            : null
                                        : () async {
                                            MessageHelper.showInfoAlert(
                                              context: context,
                                              title: 'Checking In',
                                              desc: 'Do you want to check in?',
                                              okBtnText: 'Yes',
                                              cancelBtnText: 'No',
                                              btnCancelOnPress: () {
                                                //Navigator.pop(context);
                                              },
                                              btnOkOnPress: () async {
                                                if (shifts.isNotEmpty) {
                                                  String gractTimeString =
                                                      await readValue(
                                                          graceTime);
                                                  var format = DateFormat(
                                                          'yyyy-MM-dd')
                                                      .format(DateTime.now());
                                                  DateTime initialTime =
                                                      DateTime.parse(
                                                          '$format $gractTimeString');
                                                  var attendanceDate =
                                                      DateTime.now().toLocal();
                                                  if (attendanceDate.isAfter(
                                                      initialTime.toLocal())) {
                                                    var timeDifference =
                                                        attendanceDate
                                                            .difference(
                                                                initialTime
                                                                    .toLocal());
                                                    getTimeOutDetail(
                                                        controller,
                                                        contextmain,
                                                        timeDifference);
                                                  } else {
                                                    await getAltitude(
                                                      controller,
                                                      isCheckIn: true,
                                                      contextmain,
                                                    );
                                                  }
                                                } else {
                                                  await getAltitude(
                                                    isCheckIn: true,
                                                    controller,
                                                    contextmain,
                                                  );
                                                }
                                              },
                                            );
                                          }
                                    : () async {
                                        MessageHelper.showInfoAlert(
                                          context: context,
                                          title: 'Checking In',
                                          desc: 'Do you want to check in?',
                                          okBtnText: 'Yes',
                                          cancelBtnText: 'No',
                                          btnCancelOnPress: () {
                                            //Navigator.pop(context);
                                          },
                                          btnOkOnPress: () async {
                                            if (shifts.isNotEmpty) {
                                              String gractTimeString =
                                                  await readValue(graceTime);
                                              var format =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(DateTime.now());
                                              DateTime initialTime =
                                                  DateTime.parse(
                                                      '$format $gractTimeString');
                                              var checkInAttendance =
                                                  DateTime.now().toLocal();
                                              if (checkInAttendance.isAfter(
                                                  initialTime.toLocal())) {
                                                var timeDifference =
                                                    checkInAttendance
                                                        .difference(initialTime
                                                            .toLocal());
                                                getTimeOutDetail(
                                                    controller,
                                                    contextmain,
                                                    timeDifference);
                                              } else {
                                                await getAltitude(
                                                  controller,
                                                  contextmain,
                                                  isCheckIn: true,
                                                );
                                              }
                                            } else {
                                              await getAltitude(
                                                controller,
                                                contextmain,
                                                isCheckIn: true,
                                              );
                                            }
                                          },
                                        );
                                      },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: context.width / 4,
                                      child: Center(
                                          child: controller
                                                  .attendances.isNotEmpty
                                              ? controller.attendances.last
                                                      .details.isNotEmpty
                                                  ? controller.attendances.last
                                                          .details.length.isOdd
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons.pending,
                                                          color: Colors.grey,
                                                        )
                                                  : Icon(
                                                      Icons.pending,
                                                      color: Colors.grey,
                                                    )
                                              : Icon(
                                                  Icons.pending,
                                                  color: Colors.grey,
                                                )),
                                    ),
                                    Text(
                                      "Check In".toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.attendances.isNotEmpty
                                        ? controller.attendances.last.details
                                                .isNotEmpty
                                            ? controller.attendances.last
                                                    .details.length.isOdd
                                                ? Text(MyDateUtils.getTimeOnly(
                                                        controller
                                                            .attendances
                                                            .last
                                                            .details
                                                            .last
                                                            .attendance_date!
                                                            .toLocal())
                                                    //'${controller.attendances.last.details.last.attendance_date!.toLocal().hour}:${controller.attendances.last.details.last.attendance_date!.toLocal().minute}'
                                                    )
                                                : Text('N/A')
                                            : Text('N/A')
                                        : Text('N/A')
                                  ],
                                ),
                              ),
                              VerticalDivider(
                                color: Pallete.primaryCol,
                                thickness: 1.3,
                                endIndent: 3,
                                indent: 0,
                              ),
                              InkWell(
                                onTap: controller.attendances.isNotEmpty
                                    ? controller
                                            .attendances.last.details.isNotEmpty
                                        ? controller.attendances.last.details
                                                .length.isOdd
                                            ? () async {
                                                MessageHelper.showInfoAlert(
                                                  context: context,
                                                  title: 'Checking Out',
                                                  desc:
                                                      'Do you want to check out?',
                                                  okBtnText: 'Yes',
                                                  cancelBtnText: 'No',
                                                  btnCancelOnPress: () {
                                                    //Navigator.pop(context);
                                                  },
                                                  btnOkOnPress: () async {
                                                    if (shifts.isNotEmpty) {
                                                      String lunchInTimeString =
                                                          await readValue(
                                                              lunchInTime);
                                                      String
                                                          gractEndTimeString =
                                                          await readValue(
                                                              graceEnd);
                                                      var format = DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(
                                                              DateTime.now());
                                                      DateTime graceEndTime =
                                                          DateTime.parse(
                                                              '$format $gractEndTimeString');
                                                      DateTime startLunchTime =
                                                          DateTime.parse(
                                                              '$format $lunchInTimeString');
                                                      var checkOutAttendance =
                                                          DateTime.now()
                                                              .toLocal();
                                                      if (controller
                                                                  .attendances
                                                                  .last
                                                                  .details
                                                                  .length ==
                                                              1 &&
                                                          lunchInTimeString !=
                                                              "00:00:01") {
                                                        if (checkOutAttendance
                                                            .isBefore(
                                                                startLunchTime
                                                                    .toLocal())) {
                                                          var timeDifference1 =
                                                              startLunchTime
                                                                  .toLocal()
                                                                  .difference(
                                                                      checkOutAttendance);
                                                          getTimeOutDetail(
                                                              controller,
                                                              contextmain,
                                                              timeDifference1,
                                                              checkOut: true,
                                                              beforeLunch:
                                                                  true);
                                                        } else if (checkOutAttendance
                                                            .isBefore(graceEndTime
                                                                .toLocal())) {
                                                          var timeDifference2 =
                                                              graceEndTime
                                                                  .toLocal()
                                                                  .difference(
                                                                      checkOutAttendance);
                                                          getTimeOutDetail(
                                                              controller,
                                                              contextmain,
                                                              timeDifference2,
                                                              checkOut: true);
                                                        } else {
                                                          await getAltitude(
                                                            controller,
                                                            contextmain,
                                                            isCheckIn: false,
                                                          );
                                                        }
                                                      } else if (checkOutAttendance
                                                          .isBefore(graceEndTime
                                                              .toLocal())) {
                                                        var timeDifference3 =
                                                            graceEndTime
                                                                .toLocal()
                                                                .difference(
                                                                    checkOutAttendance);
                                                        getTimeOutDetail(
                                                            controller,
                                                            contextmain,
                                                            timeDifference3,
                                                            checkOut: true);
                                                      } else {
                                                        await getAltitude(
                                                            controller,
                                                            isCheckIn: false,
                                                            contextmain);
                                                      }
                                                    } else {
                                                      await getAltitude(
                                                        isCheckIn: false,
                                                        controller,
                                                        contextmain,
                                                      );
                                                    }
                                                  },
                                                );
                                              }
                                            : null
                                        : null
                                    : null,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: context.width / 4,
                                      child: Center(
                                          child: controller
                                                  .attendances.isNotEmpty
                                              ? controller.attendances.last
                                                      .details.isNotEmpty
                                                  ? controller.attendances.last
                                                          .details.length.isEven
                                                      ? Icon(
                                                          Icons.check,
                                                          color: Colors.green,
                                                        )
                                                      : Icon(
                                                          Icons.pending,
                                                          color: Colors.grey,
                                                        )
                                                  : SizedBox.shrink()
                                              : SizedBox.shrink()),
                                    ),
                                    controller.attendances.isNotEmpty
                                        ? controller.attendances.last.details
                                                .isNotEmpty
                                            ? controller.attendances.last
                                                    .details.length.isEven
                                                ? SizedBox.shrink()
                                                : SizedBox.shrink()
                                            : SizedBox.shrink()
                                        : Icon(
                                            Icons.pending,
                                            color: Colors.grey,
                                          ),
                                    Text(
                                      "Check Out".toUpperCase(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    controller.attendances.isNotEmpty
                                        ? controller.attendances.last.details
                                                .isNotEmpty
                                            ? controller.attendances.last
                                                    .details.length.isEven
                                                ? Text(MyDateUtils.getTimeOnly(
                                                    controller
                                                        .attendances
                                                        .last
                                                        .details
                                                        .last
                                                        .attendance_date!
                                                        .toLocal()))
                                                : Text('N/A')
                                            : SizedBox.shrink()
                                        : Text('N/A')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(
                          height: 30,
                          child: Text(
                              'Check in/out feature disabled, as user denied location access'),
                        )
                ],
              ),
            ),
          );
        });
      });
    });
  }

  Future<void> _punch(
    AttendanceController controller,
    BuildContext context, {
    List<String?>? details,
    required bool isCheckIn,
  }) async {
    await controller.punch(details);
    if (StorageHelper.liveTracking == "1") {
      if (Platform.isAndroid) {
        BaseResponse? data = await Get.find<SfaLocationLogsController>()
            .convertListStringToSfaLocationModel(isCheckIn: isCheckIn);
        if (data != null) {
          if (data.status == 'success') {
            showDialogBox = false;
            MessageHelper.showSuccessAlert(
                context: context,
                title: 'Location Data Synced',
                desc: data.data,
                okBtnText: 'Ok',
                btnOkOnPress: () async {
                  showDialogBox = false;
                });
          } else if (data.status == 'error') {
            showDialogBox = false;
            MessageHelper.errorDialog(
              context: context,
              errorMessage: data.data,
              btnOkText: 'Ok',
              btnOkOnPress: () {
                showDialogBox = false;
              },
            );
          }
        } else {
          showDialogBox = false;
        }
      }
      if (context.mounted && controller.message != null) {
        MessageHelper.showSuccessAlert(
          context: context,
          title: controller.message!,
          btnOkOnPress: () {
            showDialogBox = false;
          },
        );
      }
    }
  }
}
