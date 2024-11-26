import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_peopler/src/controllers/navController.dart';
import 'package:my_peopler/src/core/constants/navigatorId.dart';
import 'package:my_peopler/src/routes/appPages.dart';
import 'package:my_peopler/src/widgets/myBottomAppBar.dart';
import 'package:my_peopler/src/widgets/myHomeFAB.dart';

class NavView extends GetView<NavController> {
  final bool? hasAppBar;
  const NavView({Key? key, this.hasAppBar = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
      onWillPop: () async {
        Get.find<NavController>().back();
        // Get.find<NavController>().offNamed(Routes.HOME);
        // controller.changeView(2);
        return false;
      },
      child: Scaffold(
        appBar: hasAppBar == true
            ? AppBar(
                title: Text("Notice Detail"),
                leading: IconButton(
                  onPressed: () {
                    Get.find<NavController>().back();
                  },
                  icon: Icon(Icons.arrow_back_ios_new),
                ),
                automaticallyImplyLeading: false,
              )
            : null,
        extendBody: true,
        body: Navigator(
          key: Get.nestedKey(NavigatorId.nestedNavigationNavigatorId),
          initialRoute: Routes.HOME,
          onGenerateRoute: (routeSettings) {
            return controller.onNestedGenerateRoute(routeSettings, context);
          },
        ),
        bottomNavigationBar: MyBottomAppBar(),
        floatingActionButton: MyHomeFAB(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
