import 'dart:developer';
import 'package:get/get.dart';
import 'package:my_peopler/src/models/payroll/payrollResponse.dart';
import 'package:my_peopler/src/models/payroll/payslip_response.dart';
import 'package:my_peopler/src/repository/repository.dart';

class PayrollController extends GetxController {
  final PayrollRepository repository;
  PayrollController(this.repository);

  final Rx<PayrollResponse?> _payrollResponse= Rx<PayrollResponse?>(null);
  Payroll? get payRoll => _payrollResponse.value?.data?.payroll;
  Bonus? get bonus => _payrollResponse.value?.data?.bonus;
  Grade? get grade => _payrollResponse.value?.data?.grade;

  List<PayslipResponse> payslipResponse = []; 

  var isRefreshing = false.obs;

  

  refreshPayroll() async {
    isRefreshing(true);
    update();
    await getPayroll();
    await getPaySlip();
    isRefreshing(false);
    update();
  }

  getPayroll() async {
    var res = await repository.getPayroll();
    if (!res.hasError) {
      _payrollResponse.value = res.data as PayrollResponse;
      log(_payrollResponse.toString(), name: "PayrollController");
      update();
    }
  }

  getPaySlip() async{
     var res = await repository.getPayslips();
    if (!res.hasError) {
      payslipResponse = res.data as List<PayslipResponse>;
      log(payslipResponse.toString(), name: "PayslipResponse");
      update();
    }
  }
}
