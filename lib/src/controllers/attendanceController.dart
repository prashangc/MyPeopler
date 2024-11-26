import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_peopler/main.dart';
import 'package:my_peopler/src/core/constants/attendanceViewMode.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/attendance/attendancesResponse.dart';
import 'package:my_peopler/src/repository/repository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';
import 'package:nepali_utils/nepali_utils.dart';

class AttendanceController extends GetxController {
  AttendanceController(this._attendanceRepo);

  final AttendanceRepository _attendanceRepo;

  final Rx<AttendancesResponse?> _attendanceResponse =
      Rx<AttendancesResponse?>(null);
  List<Attendance> get attendances =>
      _attendanceResponse.value?.attendances ?? [];
  List<Attendance> expenseAttendance = [];

  var isLoading = false.obs;
  bool? isPunching;

  String? _message;
  String? get message => _message;
  var isLoadg = false;
  getAttendance(int? employeeID) async {
    isLoadg = true;
    // update();
    var res = await _attendanceRepo.getAttendance(
        fromDate.value, toDate.value, employeeID);

    if (!res.hasError) {
      var attendance = res.data as AttendancesResponse;
      _attendanceResponse.value = attendance;
  
      log(attendances.toString(), name: "AttendanceController");
      isLoadg = false;
      update();
    }
  }

  getExpenseAttendance(
      int? employeeID, NepaliDateTime? start, NepaliDateTime? end) async {
    isLoadg = true;
    // update();
    var res = await _attendanceRepo.getAttendance(start, end, employeeID);

    if (!res.hasError) {
      expenseAttendance = res.data.attendances ?? [];
      log(attendances.toString(), name: "AttendanceController");
      isLoadg = false;
      update();
    }
  }

  Future punch(List<String?>? details) async {
    isPunching = true;
    update();
    var res = await _attendanceRepo.punch(details: details);

    isPunching = false;
    update();
    if (!res.hasError) {
      // Need better way to extract this value
      var isCheckedIn = res.data["details"]["state"] == 0;
      StorageHelper.setCheckedIn(isCheckedIn: isCheckedIn);

      var userId = StorageHelper.userId;
      assert(userId != null);
      if (isCheckedIn) {
        startBackgroundLocator(userId!);
      } else {
        stopBackgroundLocator();
      }

      await getAttendance(null);
      _message = res.data['message'];
      update();
    }
  }

  Future freezeUI() async {
    isPunching = true;
    update();
  }

  Future unfreezeUI() async {
    isPunching = false;
    update();
  }

  Future<void> refreshAttendance(int? employeeID,
      {NepaliDateTime? start,
      NepaliDateTime? endDate,
      bool isExpense = false}) async {
    isLoading(true);
    update();
    !isExpense
        ? await getAttendance(employeeID)
        : await getExpenseAttendance(employeeID, start!, endDate!);
    isLoading(false);
    update();
  }

  Rx<NepaliDateTime?> fromDate = Rx<NepaliDateTime?>(null);
  Rx<NepaliDateTime?> toDate = Rx<NepaliDateTime?>(null);

  setFromPEDate(NepaliDateTime date) async {
    fromDate.value = date;
  }

  setToPEDate(NepaliDateTime date) async {
    toDate.value = date;
  }

  handlePEFilter(int? employeeID) {
    if (fromDate.value == null || toDate.value == null) {
      return;
    }
    refreshAttendance(employeeID);
  }

  var currentMonth = NepaliDateTime.now().month.obs;
  var selectedDate = NepaliDateTime.now().obs;

  changeCurrentMonth(int month) {
    currentMonth.value = month;
  }

  var attendenceViewMode = AttendanceViewMode.LIST.obs;

  changeAtendenceViewMode() {
    attendenceViewMode.value =
        attendenceViewMode.value == AttendanceViewMode.LIST
            ? AttendanceViewMode.CALENDER
            : AttendanceViewMode.LIST;
  }

  @override
  void onInit() {
    toDate(NepaliDateTime.now());
    fromDate(NepaliDateTime(
        toDate.value!.year, toDate.value!.month, toDate.value!.day));
    getAttendance(null);
    super.onInit();
  }
}
