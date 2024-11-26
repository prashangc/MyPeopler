import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/routes/appPages.dart';

class MyHomeFAB extends GetWidget<NavController> {
  const MyHomeFAB({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !(MediaQuery.of(context).viewInsets.bottom != 0),
      child: Obx(() => FloatingActionButton(
            backgroundColor: Pallete.primaryCol,
            isExtended: true,
            child: Icon(
              Icons.home,
              size: controller.selected.value == 2 ? 22: 20,
              color: !(controller.selected.value == 2)
                  ? Colors.white.withOpacity(0.85)
                  : Colors.white,
            ),
            onPressed: () {
              controller.changeView(2, isCustomerView: false);
              Get.find<NavController>().offNamed(Routes.HOME);
            },
          )),
    );
  }
}
