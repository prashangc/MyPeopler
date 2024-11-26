import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/estimatedCustomerReportController.dart';

class CustomerReportBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<EstimatedCustomerReportController>(EstimatedCustomerReportController(), permanent: true); 
  }
}