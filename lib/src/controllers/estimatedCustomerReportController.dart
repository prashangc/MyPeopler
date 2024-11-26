
import 'dart:developer';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:my_peopler/src/core/di/injection.dart';
import 'package:my_peopler/src/models/sfa/sfa_estimated_customer_report_model.dart';
import 'package:my_peopler/src/repository/sfa/estimatedCustomerReportRepository.dart';
import 'package:my_peopler/src/utils/utils.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart';

class EstimatedCustomerReportController extends GetxController {
  final SfaEstimatedCustomerRepository _sfaEstimatedCustomerRepository =
      getIt<SfaEstimatedCustomerRepository>();
  bool isLoading = false;
  List<Datum> sfaCustomerReport = [];

  
  getSfaEstimatedCustomerReport(NepaliDateTime date, int? subOrdinateId, [Function? setState]) async {
    isLoading = true;
    update();
    var res = await _sfaEstimatedCustomerRepository.getSfaCustomerReport(
       MyDateUtils.getDateOnly(date), subOrdinateId
    );
     sfaCustomerReport = res;
      log(sfaCustomerReport.toString());
      isLoading = false;
      update();
  }

}