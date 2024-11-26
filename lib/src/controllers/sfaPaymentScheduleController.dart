import 'package:get/get.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/sfa/sfa_payment_schedule_model.dart';
import 'package:my_peopler/src/repository/sfa/sfaPaymentRepository.dart';

class PaymentScheduleData {
  String? status;
  int? paymentScheduleId;
  String? note;
  PaymentScheduleData({this.status, this.paymentScheduleId, this.note});
}

class SfaPaymentScheduleController extends GetxController {
  final SfaPaymentScheduleRepository _sfaPaymentScheduleRepo =
      getIt<SfaPaymentScheduleRepository>();
  bool isLoading = false;
  List<Datum>? sfaPaymentSchedule = [];

  @override
  void onInit() async {
    await getSfaPaymentSchedule();
    super.onInit();
  }

  getSfaPaymentSchedule() async {
    isLoading = true;
    update();
    var res = await _sfaPaymentScheduleRepo.getSfaPaymentSchedule();
    isLoading = false;
    sfaPaymentSchedule = res.data;
    update();
  }

  updatePaymentSchedule(int itemId, String planningAmount, String planning_date) async {
    var message =
        await _sfaPaymentScheduleRepo.updatePaymentSchedule(itemId: itemId, planningAmount: planningAmount, planning_date: planning_date);
    return message;
  }

}
