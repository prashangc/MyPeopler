import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/pallete.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/navButton.dart';

class CustomBottomAppBar extends GetWidget<NavController> {
  const CustomBottomAppBar({Key? key}) : super(key: key);

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
                    if (controller.changeView(0,isCustomerView: true)) {
                      Get.find<NavController>().offNamed(Routes.CUSTOMER_INVOICE);
                    }
                  },
                  icon: controller.bottomNavsCustomer[0]['icon'],
                  label: controller.bottomNavsCustomer[0]['label'],
                  selected: controller.customerSelected.value == 0,
                ),
              ),

              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(1,isCustomerView: true)) {
                      Get.find<NavController>().offNamed(Routes.CUSTOMER_ORDER_HISTORY);
                    }
                  },
                  icon: controller.bottomNavsCustomer[1]['icon'],
                  label: controller.bottomNavsCustomer[1]['label'],
                  selected: controller.customerSelected.value == 1,
                ),
              ),
              
              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(2,isCustomerView: true)) {
                      Get.find<NavController>().offNamed(Routes.CUSTOMER_HOME_SCREEN);
                    }
                  },
                  icon: controller.bottomNavsCustomer[2]['icon'],
                  label: controller.bottomNavsCustomer[2]['label'],
                  selected: controller.customerSelected.value == 2,
                ),
              ),
          
              Expanded(
                child: NavButton(
                  onPressed: () {
                   if (controller.changeView(3,isCustomerView: true)) {
                      Get.find<NavController>().offNamed(Routes.CUSTOMER_PRODUCT_LIST_VIEW);
                    }
                  },
                  icon: controller.bottomNavsCustomer[3]['icon'],
                  label: controller.bottomNavsCustomer[3]['label'],
                  selected: controller.customerSelected.value == 3,
                ),
              ),

              Expanded(
                child: NavButton(
                  onPressed: () {
                    if (controller.changeView(4,isCustomerView: true)) {
                      Get.find<NavController>().offNamed(Routes.CUSTOMER_PROFILE);
                    }
                  },
                  icon: controller.bottomNavsCustomer[4]['icon'],
                  label: controller.bottomNavsCustomer[4]['label'],
                  selected: controller.customerSelected.value == 4,
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
