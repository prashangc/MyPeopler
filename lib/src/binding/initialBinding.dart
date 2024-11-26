import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/controllers.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<NavController>(NavController(), permanent: true);
  }
}