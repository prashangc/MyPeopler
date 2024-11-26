import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/customer/customerProductListController.dart';

class CustomerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<CustomerProductListController>(CustomerProductListController(), permanent: true);
    
  }
}