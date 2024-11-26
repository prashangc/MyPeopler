import 'dart:developer';

import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';
import 'package:my_peopler/src/core/core.dart';
import 'package:my_peopler/src/helpers/helpers.dart';
import 'package:my_peopler/src/models/leave/leaveCategory/leaveCategoryResponse.dart';
import 'package:my_peopler/src/models/leave/remaining_leave.dart';
import 'package:my_peopler/src/models/models.dart';
import 'package:my_peopler/src/repository/leaveRepository.dart';

class LeaveController extends GetxController {
  final LeaveRepository _leaveRepo = getIt<LeaveRepository>();

  final Rx<List<Leave>> _leaves = Rx<List<Leave>>([]);
  List<Leave> get leaves => _leaves.value;

  final Rx<LeaveCategoryResponse?> _leaveCategoryResp = Rx<LeaveCategoryResponse?>(null);
  List<LeaveCategory> get leaveCategory => _leaveCategoryResp.value?.data??[];

  RemainingLeaveResponse? remainingLeaveResponse;

  var isGettingLeaves = false.obs;
  var isRequestingForLeave = false.obs;
  bool isLoading = false;
  

  callAllApi() async{
    await getLeaveCategory();
    await getLeaves();
    await getRemainingLeave();
  }

  getLeaves() async {
   
    var res = await _leaveRepo.getLeaveApplications();
    if (!res.hasError) {
      _leaves.value.clear();
      _leaves.value = res.data as List<Leave>;
      log(leaves.toString(), name: "LeaveController");
      update();
    }
  }
  getLeaveCategory() async {
     isLoading = true;
    update();
    var res = await _leaveRepo.getLeaveCategory();
    if (!res.hasError) {
      _leaveCategoryResp.value = res.data as LeaveCategoryResponse;
      log(leaveCategory.toString(), name: "LeaveController");
      isLoading = false;
      update();
    }
  }

  getRemainingLeave() async {
    var res = await _leaveRepo.getRemainingLeave();
    if (!res.hasError) {
      remainingLeaveResponse = res.data as RemainingLeaveResponse;
      log(remainingLeaveResponse.toString(), name: "remainingLeaveResponse");
      update();
    }
  }

  refreshLeaves() async {
    isGettingLeaves(true);
    update();
    getLeaves();
    isGettingLeaves(true);
    update();
  }

  requestLeave(
      {required String reason,
      required String catId,
      required String startDate,
      String? endDate}) async {
    isRequestingForLeave(true);
    update();
    var res = await _leaveRepo.requestLeaveApplication(
      {
        "leave_category_id": catId,
        "reason": reason,
        "start_date": startDate,
        "end_date": endDate,
      },
    );
    if (!res.hasError) {
      MessageHelper.success(res.data);
      refreshLeaves();
      Get.find<NavController>().back();
    } else {
      MessageHelper.error(res.error ?? "Cannot Request for leave!!!");
    }
    isRequestingForLeave(false);
    update();
  }
}
