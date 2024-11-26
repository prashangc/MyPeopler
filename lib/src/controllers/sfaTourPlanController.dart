import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/sfa/sfa_tour_plan_model.dart';
import 'package:my_peopler/src/repository/sfa/sfaTourPlanRepository.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class TourPlanData{
  String? status;
  int? tourPlanId;
  String? note;
  TourPlanData({
    this.status,
    this.tourPlanId,
    this.note
  });
}
class SfaTourPlanController extends GetxController {
  final SfaTourPlanRepository _sfaTourPlanRepo =
      getIt<SfaTourPlanRepository>();
  bool isLoading = false;
  List<SfaTourPlan> sfaTourPlans = [];
  
  postSfaProductList(SfaTourPlan tourPlan) async {
    isLoading = true;
    update();
    var res = await _sfaTourPlanRepo.postSfaTourPlan(tourPlan);
    isLoading = false;
    update();
    return res;
  }

  getSfaTourPlan({NepaliDateTime? start, NepaliDateTime? end}) async {
    isLoading = true;
    update();
    var res = await _sfaTourPlanRepo.getSfaTourPlan(start: start, end: end);
    isLoading = false;
    sfaTourPlans = res.data ?? [];
    update();
  }

   getSfaAllTourPlan({String? type, String? start, String? end,int? employeeId}) async {
    isLoading = true;
    update();
    var res = await _sfaTourPlanRepo.getSfaAllTourPlan(type: type,start:start,end:end,employeeId:employeeId);
    isLoading = false;
    sfaTourPlans = res.data ?? [];
    update();
  }

  approveTourPlan(TourPlanData data) async{
    var res = await _sfaTourPlanRepo.approveTourPlan(data);
    return res;
  }

    createTourPlanNote(int? id, String action, String note) async {
    isLoading = true;
    update();
    var res = await _sfaTourPlanRepo.createTourPlanNote(id, action, note);
    isLoading = false;
    update();
    return res;
  }

}
