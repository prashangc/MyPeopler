import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/routes/appPages.dart';

import '../../controllers/navController.dart';
import '../../core/pallete.dart';

class CustomerHomeFAB extends GetWidget<NavController> {
  const CustomerHomeFAB({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
      child: Obx(() => FloatingActionButton(
            backgroundColor: Pallete.primaryCol,
            isExtended: true,
            child: Icon(
              Icons.home,
              size: controller.customerSelected.value == 2 ? 22: 20,
              color: !(controller.customerSelected.value == 2)
                  ? Colors.white.withOpacity(0.85)
                  : Colors.white,
            ),
            onPressed: () {
             controller.changeView(2,isCustomerView: true);
             Get.find<NavController>().offNamed(Routes.CUSTOMER_HOME_SCREEN);
            },
          )),
    );
  }
}