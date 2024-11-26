import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/navButton.dart';

class MyBottomAppBar extends GetWidget<NavController> {
  const MyBottomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8,
      color: Pallete.primaryCol,
      child: SizedBox(
        height: 60,
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(0, isCustomerView: false)) {
                      Get.find<NavController>().offNamed(Routes.ATTENDANCE);
                    }
                  },
                  icon: controller.bottomNavs[0]['icon'],
                  label: controller.bottomNavs[0]['label'],
                  selected: controller.selected.value == 0,
                ),
              ),
              
              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(1, isCustomerView: false)) {
                      Get.find<NavController>().offNamed(Routes.LEAVE);
                    }
                  },
                  icon: controller.bottomNavs[1]['icon'],
                  label: controller.bottomNavs[1]['label'],
                  selected: controller.selected.value == 1,
                ),
              ),
              // SizedBox(
              //   width: 40,
              // ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     NavButton(
              //       onPressed: () {
              //         controller.changeView(3);
              //       },
              //       icon: controller.bottomNavs[3]['icon'],
              //       label: controller.bottomNavs[3]['label'],
              //       selected: controller.selected.value == 3,
              //     ),
              //     NavButton(
              //       onPressed: () {
              //         controller.changeView(4);
              //       },
              //       icon: controller.bottomNavs[4]['icon'],
              //       label: controller.bottomNavs[4]['label'],
              //       selected: controller.selected.value == 4,
              //     ),
              //   ],
              // ),
              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(3, isCustomerView: false)) {
                      Get.find<NavController>().offNamed(Routes.PAYROLL);
                    }
                  },
                  icon: controller.bottomNavs[3]['icon'],
                  label: controller.bottomNavs[3]['label'],
                  selected: controller.selected.value == 3,
                ),
              ),
              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(4, isCustomerView: false)) {
                      Get.find<NavController>().offNamed(Routes.PROFILE);
                    }
                  },
                  icon: controller.bottomNavs[4]['icon'],
                  label: controller.bottomNavs[4]['label'],
                  selected: controller.selected.value == 4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class Try extends GetWidget<NavController> {
  const Try({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      
      notchMargin: 8,
      color: Pallete.primaryCol,
      child: SizedBox(
        height: 60,
      ),
    );
  }
}
