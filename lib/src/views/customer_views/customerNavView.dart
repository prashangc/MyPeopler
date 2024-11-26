import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/widgets/customer/customerBottomAppBar.dart';
import 'package:my_peopler/src/widgets/customer/customerHomeFAB.dart';
import '../../controllers/navController.dart';
import '../../core/core.dart';
import '../../routes/routes.dart';

class CustomerNavView extends GetView<NavController> {
  final bool? hasAppBar;
  const CustomerNavView({Key? key, this.hasAppBar = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavController>().back();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          resizeToAvoidBottomInset: true,
          body: Navigator(
            key: Get.nestedKey(NavigatorId.nestedNavigationNavigatorId),
            initialRoute: Routes.CUSTOMER_HOME_SCREEN,
            onGenerateRoute: (routeSettings) {
              return controller.onNestedGenerateRouteCustomer(routeSettings, context);
            },
          ),
           bottomNavigationBar: CustomBottomAppBar(),
           floatingActionButton: CustomerHomeFAB(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}